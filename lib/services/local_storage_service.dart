import 'dart:convert';

import 'package:cody/models/storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/account.dart';

class LocalStorageService implements Storage {

  final FlutterSecureStorage storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true)
  );

  @override
  Future<void> saveAccount(Account account) async {
    await storage.write(key: account.id!, value: jsonEncode(account));
  }

  @override
  Future<List<Account>> getAccounts() async {
    Map<String, String> allAccountsJsons = await storage.readAll();
    List<Account> allAccounts = List.empty(growable: true);

    allAccountsJsons.values.toList().forEach((String accountJson) {
      allAccounts.add(Account.fromJson(jsonDecode(accountJson)));
    });

    return allAccounts;
  }

  @override
  Future<void> removeAccount(Account account) async {
    await storage.delete(key: account.id!);
  }

  @override
  Future<void> clearStorage() async {
    await storage.deleteAll();
  }
}
