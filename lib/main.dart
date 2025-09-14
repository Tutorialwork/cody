import 'package:cody/services/get_it_service.dart';
import 'package:cody/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'constants/list_constants.dart';
import 'l10n/app_localizations.dart';

void main() {
  GetItService.registerSingletons();

  runApp(MaterialApp(
    localizationsDelegates: [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: ListsConstants.supportedLocales,
    home: SplashScreen(),
  ));
}
