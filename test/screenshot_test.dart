/// This file contains the tests that take screenshots of the app.
///
/// Run it with `flutter test --update-goldens` to generate the screenshots
/// or `flutter test` to compare the screenshots to the golden files.
library;

import 'dart:async';

import 'package:cody/constants/list_constants.dart';
import 'package:cody/l10n/app_localizations.dart';
import 'package:cody/pages/codes_page.dart';
import 'package:cody/pages/leaked_password_checker_page.dart';
import 'package:cody/pages/password_generator_page.dart';
import 'package:cody/services/accounts_data_service.dart';
import 'package:cody/services/app_preferences_service.dart';
import 'package:cody/services/navigator_service.dart';
import 'package:cody/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:golden_screenshot/golden_screenshot.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mocked_data/mock_codes_data.dart';
import 'cody_golden_screenshot_devices.dart';
import 'screenshot_test.mocks.dart';

@GenerateMocks([
  AccountsDataService,
  NavigatorService,
])
void main() {

  final getIt = GetIt.instance;

  late AccountsDataService accountsDataService;
  late NavigatorService navigatorService;
  late AppPreferencesService appPreferencesService;

  setUpAll(() {
    accountsDataService = MockAccountsDataService();
    navigatorService = MockNavigatorService();
    appPreferencesService = AppPreferencesService();

    getIt.registerSingleton<AccountsDataService>(accountsDataService);
    getIt.registerSingleton<NavigatorService>(navigatorService);
    getIt.registerSingleton<AppPreferencesService>(appPreferencesService);

    GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

    when(navigatorService.navigatorKey).thenReturn(navKey);
    when(navigatorService.currentActiveRoute).thenReturn('codes');

    StreamController<void> updateStream = StreamController.broadcast();

    when(accountsDataService.isLoadingData).thenReturn(false);
    when(accountsDataService.updateStream).thenReturn(updateStream);
    when(accountsDataService.accounts).thenReturn(MockCodesData.getData());
  });

  group('Screenshot:', () {
    TestWidgetsFlutterBinding.ensureInitialized();

    final homePageTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
    );

    _screenshotWidget(
        theme: homePageTheme,
        goldenFileName: 'codes_page',
        child: Scaffold(
            body: SafeArea(
              child: CodesPage(),
            ),
            bottomNavigationBar: Navbar('codes', (_) => {}),),
        ingestDataFunction: (WidgetTester tester, String locale) { }
    );

    _screenshotWidget(
        theme: homePageTheme,
        goldenFileName: 'password_checker_page',
        child: Scaffold(
          body: SafeArea(
            child: LeakedPasswordCheckerPage(),
          ),
          bottomNavigationBar: Navbar('password/checker', (_) => {}),),
        ingestDataFunction: (WidgetTester tester, String locale) {
          final state = tester.state<LeakedPasswordCheckerPageState>(find.byType(LeakedPasswordCheckerPage));

          state.setState(() {
            state.passwordLeakedCount = 9991639;
            state.controller.text = 'Password';
          });
        }
    );

    _screenshotWidget(
        theme: homePageTheme,
        goldenFileName: 'password_generator_page',
        child: Scaffold(
          body: SafeArea(
            child: PasswordGeneratorPage(),
          ),
          bottomNavigationBar: Navbar('password/generator', (_) => {}),),
        ingestDataFunction: (WidgetTester tester, String locale) { }
    );
  });
}

void _screenshotWidget({
  ThemeData? theme,
  required String goldenFileName,
  required Widget child,
  required Function(WidgetTester, String locale) ingestDataFunction
}) {
  List locales = List<String>.of(['en', 'de']);

  group(goldenFileName, () {
    for (final locale in locales) {
      for (final goldenDevice in CodyGoldenScreenshotDevices.values) {
        testGoldens('for ${goldenDevice.name}', (WidgetTester tester) async {
          ScreenshotDevice device = goldenDevice.device;

          Widget widget = ScreenshotApp(
            theme: theme,
            device: device,
            child: child,
            supportedLocales: ListsConstants.supportedLocales,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: Locale(locale),
          );

          await tester.pumpWidget(widget);
          await tester.pumpAndSettle(); // wait for animations or async tasks

          ingestDataFunction(tester, locale);

          await tester.precacheImagesInWidgetTree();
          await tester.precacheTopbarImages();
          await tester.loadFonts();

          await tester.pumpFrames(widget, const Duration(seconds: 1));

          await tester.expectScreenshot(device, goldenFileName, langCode: locale);
        });
      }
    }
  });
}