part of 'totp_bloc.dart';

@immutable
abstract class TotpState {}

class TotpInitial extends TotpState {}

class TotpSecretGiven extends TotpState {
  final String id;
  final String provider;
  final String accountName;
  final String secret;

  TotpSecretGiven(this.provider, this.accountName, this.secret, this.id);

}

class TotpCodeGenerated extends TotpState {
  final String id;
  final String provider;
  final String accountName;
  final String secret;
  final String code;
  final DateTime expiresAt;

  TotpCodeGenerated(this.provider, this.accountName, this.secret, this.code, this.expiresAt, this.id);

  Account toAccount() {
    return Account(id, provider, accountName, secret, false, DateTime.fromMillisecondsSinceEpoch(0));
  }

}