import 'package:cody/models/arguments/edit_account_page_arguments.dart';
import 'package:cody/models/arguments/scan_qr_code_page_arguments.dart';
import 'package:cody/pages/codes_page.dart';
import 'package:cody/pages/edit_account_page.dart';
import 'package:cody/pages/leaked_password_checker_page.dart';
import 'package:cody/pages/password_generator_page.dart';
import 'package:cody/pages/scan_qr_code_page.dart';
import 'package:cody/pages/settings_page.dart';
import 'package:cody/services/navigator_service.dart';
import 'package:cody/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  final NavigatorService navigatorService = GetIt.I<NavigatorService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Navigator(
          key: navigatorService.navigatorKey,
          initialRoute: 'codes',
          onGenerateRoute: (RouteSettings settings) =>
              _onGenerateRoute(settings),
        )),
        bottomNavigationBar: Navbar(navigatorService.currentActiveRoute,
            (String newRouteName) => _onPageRouteChanged(newRouteName)));
  }

  PageRouteBuilder _onGenerateRoute(RouteSettings settings) {
    WidgetBuilder builder;

    switch (settings.name) {
      case 'codes':
        builder = (BuildContext context) => CodesPage();
        break;
      case 'codes/add':
        if (settings.arguments != null) {
          ScanQRCodePageArguments arguments =
              settings.arguments as ScanQRCodePageArguments;
          builder =
              (BuildContext context) => ScanQRCodePage(url: arguments.url);
        } else {
          builder = (BuildContext context) => ScanQRCodePage();
        }
        break;
      case 'codes/edit':
        EditAccountPageArguments arguments =
            settings.arguments as EditAccountPageArguments;
        builder = (BuildContext context) => EditAccountPage(
            account: arguments.account, onSave: arguments.onSave);
        break;
      case 'password/generator':
        builder = (BuildContext context) => PasswordGeneratorPage();
        break;
      case 'password/checker':
        builder = (BuildContext context) => LeakedPasswordCheckerPage();
        break;
      case 'settings':
        builder = (BuildContext context) => SettingsPage();
        break;
      default:
        throw Exception('Invalid route: ${settings.name}');
    }

    _updateUI();

    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => builder(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.95, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeIn),
          ),
          child: child,
        );
      },
    );
  }

  void _onPageRouteChanged(String newRouteName) {
    if (newRouteName == navigatorService.currentActiveRoute) {
      return;
    }

    navigatorService.navigateTo(newRouteName);
  }

  void _updateUI() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }
}
