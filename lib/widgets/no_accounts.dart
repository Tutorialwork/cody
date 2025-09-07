import 'package:cody/constants/style_constants.dart';
import 'package:cody/services/navigator_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class NoAccounts extends StatelessWidget {

  final NavigatorService navigatorService = GetIt.I<NavigatorService>();

  NoAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/BlackCody.png', width: 200, height: 200,),
        Text('No codes yet', style: codeTextStyle,),
        verticalSpacingSmall,
        Text('Start using Cody by enabling two factor authentication in one of your accounts and scanning the QR code to see codes.', style: secondaryLabelTextStyle, textAlign: TextAlign.center,),
        verticalSpacingMedium,
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: CupertinoButton.filled(
            onPressed: () => navigatorService.navigateTo('codes/add'),
            color: primaryColor,
            child: Text('Scan QR code'),
          ),
        ),
      ],
    );
  }
}
