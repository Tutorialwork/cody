import 'package:cody/models/account.dart';

class EditAccountPageArguments {

  final Account account;
  final Function(Account) onSave;

  EditAccountPageArguments(this.account, this.onSave);
}