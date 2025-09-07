import 'package:cody/constants/list_constants.dart';
import 'package:cody/exceptions/otpauth_parse_exception.dart';
import 'package:cody/models/otp_auth_url.dart';
import 'package:cody/services/local_storage_service.dart';
import 'package:cody/services/navigator_service.dart';
import 'package:cody/services/otpauth_url_parser_service.dart';
import 'package:cody/services/otpauth_url_validator_service.dart';
import 'package:cody/services/toast_service.dart';
import 'package:cody/widgets/loading.dart';
import 'package:cody/widgets/page_title.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:uuid/uuid.dart';

import '../constants/style_constants.dart';
import '../models/account.dart';
import '../models/storage.dart';
import '../widgets/settings_icon.dart';

class ScanQRCodePage extends StatefulWidget {

  final String? url;

  const ScanQRCodePage({super.key, this.url});

  @override
  State<ScanQRCodePage> createState() => _ScanQRCodePageState();
}

class _ScanQRCodePageState extends State<ScanQRCodePage> {

  final NavigatorService navigatorService = GetIt.I<NavigatorService>();
  final MobileScannerController controller = MobileScannerController();

  bool isLoading = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.url != null) {
        _toggleLoading();
        controller.stop();

        _addAccount(widget.url ?? '');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: mediumSize),
        child: Column(children: [
          PageTitle(title: 'Add code'),
          const SizedBox(
            height: mediumSize,
          ),
          !isLoading ? Expanded(
            child: MobileScanner(
              controller: controller,
              onDetect: (capture) async {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  _toggleLoading();
                  await controller.stop();

                  await _addAccount(barcode.rawValue ?? '');
                }
              },
            ),
          ) : Loading(),
        ]));
  }

  Future<void> _addAccount(String url) async {
    OtpAuthUrl otpAuthUrl = OtpAuthUrlParserService.parse(url);

    try {
      OtpAuthUrlValidatorService().validateOrThrow(otpAuthUrl);
    } catch (exception) {
      ToastService.showFailureToast('Failed to add this account');
      navigatorService.navigateTo('codes');
      return;
    }

    Uuid uuid = Uuid();
    Account account = Account(uuid.v4(), otpAuthUrl.parameterIssuer ?? otpAuthUrl.labelIssuer, otpAuthUrl.accountName!, otpAuthUrl.secret!, false, DateTime.now());

    await Future.wait(ListsConstants.storageServices.map((Storage service) => service.saveAccount(account)));

    ToastService.showSuccessToast('${account.provider} successfully added');
    Haptics.vibrate(HapticsType.success);

    navigatorService.navigateTo('codes');
  }

  void _toggleLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }
}
