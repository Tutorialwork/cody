import 'package:cody/constants/style_constants.dart';
import 'package:cody/l10n/app_localizations.dart';
import 'package:cody/navigator_page.dart';
import 'package:cody/services/analytics_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LockedAppScreen extends StatefulWidget {
  const LockedAppScreen({super.key});

  @override
  State<LockedAppScreen> createState() => _LockedAppScreenState();
}

class _LockedAppScreenState extends State<LockedAppScreen> {

  @override
  void initState() {
    AnalyticsService.logScreen('Locked App', (LockedAppScreen).toString());

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _authenticate(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/WhiteCody.png'),
            verticalSpacingMedium,
            Text(
              'Cody',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            verticalSpacingSmall,
            Text(
              AppLocalizations.of(context)!.label_app_locked,
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  Future<void> _authenticate(BuildContext context) async {
    try {
      LocalAuthentication auth = LocalAuthentication();

      bool isAuthenticated = await auth.authenticate(
          localizedReason: AppLocalizations.of(context)!.label_authentication_reason);

      if (!isAuthenticated) {
        return;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NavigatorPage()),
      );
    } on PlatformException {
      return;
    }
  }
}
