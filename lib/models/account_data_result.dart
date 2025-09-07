import 'package:cody/models/account.dart';
import 'package:cody/models/storage.dart';

class AccountDataResult {

  final List<Account> fetchedAccounts;
  final Storage dataSource;

  AccountDataResult(this.fetchedAccounts, this.dataSource);
}