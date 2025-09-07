import 'package:cody/exceptions/storage_exception.dart';
import 'package:cody/models/account.dart';
import 'package:cody/models/storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cloud_kit/flutter_cloud_kit.dart';
import 'package:flutter_cloud_kit/types/cloud_ket_record.dart';
import 'package:flutter_cloud_kit/types/cloud_kit_account_status.dart';
import 'package:flutter_cloud_kit/types/database_scope.dart';

import '../constants/cloud_kit_constants.dart';

class CloudKitStorageService implements Storage {
  final FlutterCloudKit cloudKit =
      FlutterCloudKit(containerId: CloudKitConstants.containerId);

  @override
  Future<List<Account>> getAccounts() async {
    _isIcloudAccountStatusValidOrThrow();
    List<CloudKitRecord> records = await cloudKit.getRecordsByType(
        scope: CloudKitDatabaseScope.private,
        recordType: CloudKitConstants.recordTypeName);
    return records
        .map((cloudKitRecord) => Account.fromCloudKitRecord(cloudKitRecord))
        .toList();
  }

  @override
  Future<void> saveAccount(Account account) async {
    _isIcloudAccountStatusValidOrThrow();
    try {
      await cloudKit.saveRecord(
          scope: CloudKitDatabaseScope.private,
          recordType: CloudKitConstants.recordTypeName,
          record: Map.of({
            'secret': account.secret,
            'provider': account.provider,
            'account': account.accountName
          }),
          recordName: account.id);
    } catch (exception, stackTrace) {
      debugPrint('Failed to save new cloud kit account');
      debugPrint('$exception');
      debugPrint('$stackTrace');
    }
  }

  @override
  Future<void> removeAccount(Account account) async {
    List<CloudKitRecord> records = await cloudKit.getRecordsByType(
        scope: CloudKitDatabaseScope.private,
        recordType: CloudKitConstants.recordTypeName);

    try {
      CloudKitRecord record = records.singleWhere((CloudKitRecord record) => record.recordName == account.id);
      await cloudKit.deleteRecord(scope: CloudKitDatabaseScope.private, recordName: record.recordName);
    } catch (exception, stackTrace) {
      debugPrint('Failed to delete account from cloud kit');
      debugPrint('$exception');
      debugPrint('$stackTrace');
    }
  }

  Future<void> _isIcloudAccountStatusValidOrThrow() async {
    CloudKitAccountStatus accountStatus = await cloudKit.getAccountStatus();
    if (accountStatus != CloudKitAccountStatus.available) {
      throw StorageException('iCloud is not ready');
    }
  }

  @override
  Future<void> clearStorage() {
    throw UnimplementedError();
  }
}
