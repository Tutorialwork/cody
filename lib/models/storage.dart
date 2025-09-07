import 'package:cody/models/account.dart';

abstract class Storage {

  Future<void> saveAccount(Account account);

  Future<void> removeAccount(Account account);

  Future<List<Account>> getAccounts();

  Future<void> clearStorage();

}