import 'package:cody/constants/style_constants.dart';
import 'package:cody/locked_app_screen.dart';
import 'package:cody/models/app_preference.dart';
import 'package:cody/navigator_page.dart';
import 'package:cody/services/app_links_service.dart';
import 'package:cody/services/app_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final AppPreferencesService service = GetIt.I<AppPreferencesService>();

  @override
  void initState() {
    _checkAppPreferencesAndNavigate();
    AppLinksService.handleIncomingAppLinks();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Center(
        child: Image.asset('assets/images/WhiteCody.png'),
      ),
    );
  }

  Future<void> _checkAppPreferencesAndNavigate() async {
    AppPreference appPreference = await service.loadAppPreferences();

    Widget targetPage;

    if (appPreference.isAppAuthenticationEnabled) {
      targetPage = LockedAppScreen();
    } else {
      targetPage = NavigatorPage();
    }

    await Future.delayed(Duration(milliseconds: 500));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => targetPage),
    );
  }

}
