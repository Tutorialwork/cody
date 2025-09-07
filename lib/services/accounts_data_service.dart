import 'dart:async';
import 'dart:io';

import 'package:cody/blocs/totp/totp_bloc.dart';
import 'package:cody/models/account.dart';
import 'package:cody/models/account_data_result.dart';
import 'package:cody/models/storage.dart';
import 'package:cody/services/local_storage_service.dart';

import '../constants/list_constants.dart';
import 'cloud_kit_storage_service.dart';

class AccountsDataService {

  bool isLoadingData = true;
  final StreamController<void> updateStream = StreamController.broadcast();
  List<TotpBloc> accounts = List.empty(growable: true);

  Future<void> fetchNewData(Function(AccountDataResult) onAccountsFetched, {bool noLocalData = false}) async {
    if (!noLocalData) {
      List<Account> firstFetchedAccounts = await Future.any(
          ListsConstants.storageServices.map(
                  (Storage service) => service.getAccounts()
          )
      );

      onAccountsFetched(AccountDataResult(firstFetchedAccounts, LocalStorageService()));
    }

    Future.wait(
        ListsConstants.storageServices.map(
                (Storage service) => service.getAccounts()
        )
    ).then((List<List<Account>> allResults) {
      List<Account> mergedAccounts = <Account>[];
      for (List<Account> accountList in allResults) {
        mergedAccounts.addAll(accountList);
      }

      Map<String, Account> uniqueAccounts = <String, Account>{};
      for (int i = 0; i < mergedAccounts.length; i++) {
        Account account = mergedAccounts[i];
        uniqueAccounts[account.id ?? ''] = account;
      }

      List<Account> deduplicatedAccounts = uniqueAccounts.values.toList();

      onAccountsFetched(AccountDataResult(deduplicatedAccounts, CloudKitStorageService()));
    });

    isLoadingData = false;
  }

  Future<void> cleanupLocalCodes() async {
    if (!Platform.isIOS) {
      return;
    }

    Storage cloudStorage = CloudKitStorageService();
    Storage localStorage = LocalStorageService();

    List<Account> cloudAccounts = await cloudStorage.getAccounts();

    localStorage.clearStorage();
    cloudAccounts.forEach((Account account) => localStorage.saveAccount(account));
  }

  TotpBloc convertAccountToBloc(Account account) {
    TotpBloc totpBloc = TotpBloc();
    totpBloc.add(GenerateTotpCode());
    totpBloc.setTotpData(account.id ?? '', account.provider, account.accountName, account.secret);

    return totpBloc;
  }

}