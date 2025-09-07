import 'dart:math';
import 'dart:typed_data';

import 'package:base32/base32.dart';
import 'package:bloc/bloc.dart';
import 'package:cody/models/account.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';

part 'totp_event.dart';
part 'totp_state.dart';

class TotpBloc extends Bloc<TotpEvent, TotpState> {
  TotpBloc() : super(TotpInitial()) {
    on<TotpEvent>((TotpEvent event, Emitter<TotpState> emit) {
      if (event is GenerateTotpCode && state is TotpSecretGiven) {
        TotpSecretGiven totpSecretGiven = state as TotpSecretGiven;
        String generatedCode = _generateHOTP(totpSecretGiven.secret);

        emit(TotpCodeGenerated(totpSecretGiven.provider, totpSecretGiven.accountName, totpSecretGiven.secret, generatedCode, _convertExpiresInSecondsIntoDate(_secondsRemainingInInterval(30)), totpSecretGiven.id));
      }

      if (event is GenerateTotpCode && state is TotpCodeGenerated) {
        TotpCodeGenerated totpCodeGenerated = state as TotpCodeGenerated;
        int validInSeconds = totpCodeGenerated.expiresAt.difference(DateTime.now()).inSeconds;
        if (validInSeconds == 0) {
          String generatedCode = _generateHOTP(totpCodeGenerated.secret);

          emit(TotpCodeGenerated(totpCodeGenerated.provider, totpCodeGenerated.accountName, totpCodeGenerated.secret, generatedCode, _convertExpiresInSecondsIntoDate(_secondsRemainingInInterval(30)), totpCodeGenerated.id));
        }
      }
    });
  }

  void setTotpData(String id, String provider, String accountName, String secret) {
    if (state is TotpInitial) {
      emit(TotpSecretGiven(provider, accountName, secret, id));
    }
  }

  String _generateHOTP(String secret, {int digits = 6}) {
    final period = 30;
    final counter = (DateTime.now().millisecondsSinceEpoch ~/ (period * 1000)).toUnsigned(64);

    final secretData = _base32DecodeToData(secret.toUpperCase());
    if (secretData == null) {
      return "";
    }

    final counterBytes = _intToBytes(counter);

    final hmacSha1 = Hmac(sha1, secretData);
    final hash = hmacSha1.convert(Uint8List.fromList(counterBytes));

    final offset = hash.bytes.last & 0x0F;

    final truncatedHash = (hash.bytes[offset] & 0x7F) << 24 |
    (hash.bytes[offset + 1] << 16) |
    (hash.bytes[offset + 2] << 8) |
    hash.bytes[offset + 3];

    var hotp = truncatedHash % pow(10, digits);
    return hotp.toString().padLeft(digits, '0');
  }

  Uint8List? _base32DecodeToData(String input) {
    try {
      return base32.decode(input);
    } catch (e) {
      return null;
    }
  }

  List<int> _intToBytes(int value) {
    final byteData = ByteData(8);
    byteData.setInt64(0, value, Endian.big);
    final result = List<int>.generate(8, (index) => byteData.getUint8(index));
    return result;
  }

  int _secondsRemainingInInterval(int intervalInSeconds) {
    final currentTimeMillis = DateTime.now().millisecondsSinceEpoch;
    final currentSeconds = currentTimeMillis ~/ 1000;

    final nextIntervalStart = ((currentSeconds ~/ intervalInSeconds) + 1) * intervalInSeconds;

    final secondsRemaining = nextIntervalStart - currentSeconds;

    return secondsRemaining;
  }
  
  DateTime _convertExpiresInSecondsIntoDate(int expiresInSeconds) {
    final int nowInMillis = DateTime.now().millisecondsSinceEpoch;
    final int secondsInMillis = expiresInSeconds * 1000;

    return DateTime.fromMillisecondsSinceEpoch(nowInMillis + secondsInMillis);
  }

  Account toAccount(TotpCodeGenerated state) {
    return Account(state.id, state.provider, state.accountName, state.secret, false, DateTime.fromMillisecondsSinceEpoch(0));
  }
}
