part of 'totp_bloc.dart';

@immutable
abstract class TotpEvent {}

class GenerateTotpCode extends TotpEvent {}