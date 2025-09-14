// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get error => 'Error';

  @override
  String get error_empty_provider => 'Provider field must be filled';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get save => 'Save';

  @override
  String get password => 'Password';

  @override
  String get edit_account_page_title => 'Edit account';

  @override
  String get account_name => 'Account name';

  @override
  String get provider => 'Provider';

  @override
  String get question_deleting_account_title => 'Deleting account?';

  @override
  String get question_deleting_account_message =>
      'Do you really want to delete this account?';

  @override
  String get label_deleting_account_confirm => 'Yes, delete';

  @override
  String get label_deleting_account_cancel => 'No, cancel';

  @override
  String get label_generate_password_button => 'Generate password';

  @override
  String get label_check_password_security => 'Check password security';

  @override
  String get toast_password_copied_to_clipboard =>
      'Password copied to clipboard';

  @override
  String get toast_password_cannot_be_empty => 'Password can\\\'t be empty.';

  @override
  String get toast_account_cannot_be_added => 'Failed to add this account.';

  @override
  String get toast_account_successfully_added =>
      '%provider% successfully added.';

  @override
  String get password_checker_title => 'Password checker';

  @override
  String get label_password_not_breached =>
      'This password was never found in any known data breach.';

  @override
  String get label_password_breached =>
      'This password was found in %count% known data breaches.';

  @override
  String get add_code_title => 'Add code';

  @override
  String get settings_title => 'Settings';

  @override
  String get label_app_authentication => 'App authentication';

  @override
  String get label_show_account_names => 'Show account names';

  @override
  String get label_write_review => 'Write review';

  @override
  String get label_developed_by => 'Developed by Manuel Schuler';

  @override
  String get label_app_locked =>
      'The app is locked to show your codes please authenticate.';

  @override
  String get label_authentication_reason =>
      'Please authenticate to show your accounts.';
}
