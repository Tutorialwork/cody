import 'package:app_links/app_links.dart';
import 'package:cody/models/arguments/scan_qr_code_page_arguments.dart';
import 'package:cody/services/navigator_service.dart';
import 'package:get_it/get_it.dart';

class AppLinksService {

  static AppLinks appLinks = AppLinks();
  static NavigatorService navigatorService = GetIt.I<NavigatorService>();

  static void handleIncomingAppLinks() {
    appLinks.uriLinkStream.listen((Uri uri) {
      ScanQRCodePageArguments scanQRCodePageArguments = ScanQRCodePageArguments(uri.toString());
      navigatorService.navigateTo('codes/add', scanQRCodePageArguments);
    });
  }

}