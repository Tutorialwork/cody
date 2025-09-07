import 'package:cody/constants/style_constants.dart';
import 'package:cody/navigator_page.dart';
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
  void didChangeDependencies() {
    _authenticate(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: primaryColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/WhiteCody.png'),
              verticalSpacingMedium,
              Text('Cody', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
              verticalSpacingSmall,
              Text('The app is locked to show your codes please authenticate.', style: TextStyle(fontSize: 15), textAlign: TextAlign.center,)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _authenticate(BuildContext context) async {
    try {
      LocalAuthentication auth = LocalAuthentication();

      print(await auth.getAvailableBiometrics());

      bool isAuthenticated = await auth.authenticate(
          localizedReason: 'Please authenticate to show your codes');

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
