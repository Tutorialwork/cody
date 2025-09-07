import 'package:flutter_cloud_kit/types/cloud_ket_record.dart';

class Account {
  final String? id;
  final String provider;
  final String accountName;
  final String secret;

  bool isDirty;
  DateTime lastModified;

  Account(this.id, this.provider, this.accountName, this.secret, this.isDirty, this.lastModified);

  static Account fromCloudKitRecord(CloudKitRecord record) {
    return Account(record.recordName, record.values['provider'], record.values['account'],
        record.values['secret'], false, DateTime.fromMillisecondsSinceEpoch(0));
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'provider': provider, 'accountName': accountName, 'secret': secret, 'isDirty': isDirty, 'lastModified': lastModified.toIso8601String()};

  static Account fromJson(Map<String, dynamic> json) =>
      Account(json['id'], json['provider'], json['accountName'], json['secret'], json['isDirty'], DateTime.parse(json['lastModified']));

  @override
  String toString() {
    return 'Account{id: $id, provider: $provider, accountName: $accountName, secret: $secret, isDirty: $isDirty, lastModified: $lastModified}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Account &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          provider == other.provider &&
          accountName == other.accountName &&
          secret == other.secret &&
          isDirty == other.isDirty;

  @override
  int get hashCode =>
      Object.hash(id, provider, accountName, secret, isDirty);
}
