// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get error => 'Fehler';

  @override
  String get error_empty_provider => 'Das Anbieter Feld ist erforderlich.';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get delete => 'Löschen';

  @override
  String get save => 'Speichern';

  @override
  String get password => 'Passwort';

  @override
  String get edit_account_page_title => 'Account bearbeiten';

  @override
  String get account_name => 'Accountname';

  @override
  String get provider => 'Anbieter';

  @override
  String get question_deleting_account_title => 'Account wirklich löschen?';

  @override
  String get question_deleting_account_message =>
      'Soll dieser Account wirklich unwiderruflich gelöscht werden?';

  @override
  String get label_deleting_account_confirm => 'Ja löschen';

  @override
  String get label_deleting_account_cancel => 'Nein nicht löschen';

  @override
  String get label_generate_password_button => 'Passwort generieren';

  @override
  String get label_check_password_security => 'Passwortsicherheit überprüfen';

  @override
  String get toast_password_copied_to_clipboard =>
      'Passwort in die Zwischenablage kopiert';

  @override
  String get toast_password_cannot_be_empty => 'Passwort kann nicht leer sein.';

  @override
  String get toast_account_cannot_be_added =>
      'Account konnte nicht hinzugefügt werden.';

  @override
  String get toast_account_successfully_added =>
      '%provider% erfolgreich hinzugefügt.';

  @override
  String get password_checker_title => 'Passwort überprüfen';

  @override
  String get label_password_not_breached =>
      'Dieses Passwort wurde in keinem Datenleck gefunden.';

  @override
  String get label_password_breached =>
      'Dieses Passwort wurde bereits in %count% Datenlecks gefunden.';

  @override
  String get add_code_title => 'Account hinzufügen';

  @override
  String get settings_title => 'Einstellungen';

  @override
  String get label_app_authentication => 'App-Schutz';

  @override
  String get label_show_account_names => 'Accountnamen anzeigen';

  @override
  String get label_write_review => 'Bewertung schreiben';

  @override
  String get label_developed_by => 'Entwickelt von Manuel Schuler';

  @override
  String get label_app_locked =>
      'Die App ist momentan gesperrt. Um deine Accounts anzuzeigen entsperre die App.';

  @override
  String get label_authentication_reason =>
      'Bitte authentifiziere dich um deine Accounts anzuzeigen.';
}
