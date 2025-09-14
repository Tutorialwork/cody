import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en')
  ];

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @error_empty_provider.
  ///
  /// In en, this message translates to:
  /// **'Provider field must be filled'**
  String get error_empty_provider;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @edit_account_page_title.
  ///
  /// In en, this message translates to:
  /// **'Edit account'**
  String get edit_account_page_title;

  /// No description provided for @account_name.
  ///
  /// In en, this message translates to:
  /// **'Account name'**
  String get account_name;

  /// No description provided for @provider.
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get provider;

  /// No description provided for @question_deleting_account_title.
  ///
  /// In en, this message translates to:
  /// **'Deleting account?'**
  String get question_deleting_account_title;

  /// No description provided for @question_deleting_account_message.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to delete this account?'**
  String get question_deleting_account_message;

  /// No description provided for @label_deleting_account_confirm.
  ///
  /// In en, this message translates to:
  /// **'Yes, delete'**
  String get label_deleting_account_confirm;

  /// No description provided for @label_deleting_account_cancel.
  ///
  /// In en, this message translates to:
  /// **'No, cancel'**
  String get label_deleting_account_cancel;

  /// No description provided for @label_generate_password_button.
  ///
  /// In en, this message translates to:
  /// **'Generate password'**
  String get label_generate_password_button;

  /// No description provided for @label_check_password_security.
  ///
  /// In en, this message translates to:
  /// **'Check password security'**
  String get label_check_password_security;

  /// No description provided for @toast_password_copied_to_clipboard.
  ///
  /// In en, this message translates to:
  /// **'Password copied to clipboard'**
  String get toast_password_copied_to_clipboard;

  /// No description provided for @toast_password_cannot_be_empty.
  ///
  /// In en, this message translates to:
  /// **'Password can\\\'t be empty.'**
  String get toast_password_cannot_be_empty;

  /// No description provided for @toast_account_cannot_be_added.
  ///
  /// In en, this message translates to:
  /// **'Failed to add this account.'**
  String get toast_account_cannot_be_added;

  /// No description provided for @toast_account_successfully_added.
  ///
  /// In en, this message translates to:
  /// **'%provider% successfully added.'**
  String get toast_account_successfully_added;

  /// No description provided for @password_checker_title.
  ///
  /// In en, this message translates to:
  /// **'Password checker'**
  String get password_checker_title;

  /// No description provided for @label_password_not_breached.
  ///
  /// In en, this message translates to:
  /// **'This password was never found in any known data breach.'**
  String get label_password_not_breached;

  /// No description provided for @label_password_breached.
  ///
  /// In en, this message translates to:
  /// **'This password was found in %count% known data breaches.'**
  String get label_password_breached;

  /// No description provided for @add_code_title.
  ///
  /// In en, this message translates to:
  /// **'Add code'**
  String get add_code_title;

  /// No description provided for @settings_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_title;

  /// No description provided for @label_app_authentication.
  ///
  /// In en, this message translates to:
  /// **'App authentication'**
  String get label_app_authentication;

  /// No description provided for @label_show_account_names.
  ///
  /// In en, this message translates to:
  /// **'Show account names'**
  String get label_show_account_names;

  /// No description provided for @label_write_review.
  ///
  /// In en, this message translates to:
  /// **'Write review'**
  String get label_write_review;

  /// No description provided for @label_developed_by.
  ///
  /// In en, this message translates to:
  /// **'Developed by Manuel Schuler'**
  String get label_developed_by;

  /// No description provided for @label_app_locked.
  ///
  /// In en, this message translates to:
  /// **'The app is locked to show your codes please authenticate.'**
  String get label_app_locked;

  /// No description provided for @label_authentication_reason.
  ///
  /// In en, this message translates to:
  /// **'Please authenticate to show your accounts.'**
  String get label_authentication_reason;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
