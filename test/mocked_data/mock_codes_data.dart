import 'dart:math';

import 'package:cody/blocs/totp/totp_bloc.dart';
import 'package:uuid/uuid.dart';

class MockCodesData {
  static List<TotpBloc> getData() {
    return List.of({
      _generateTotpBloc('Google', ''),
      _generateTotpBloc('Instagram', ''),
      _generateTotpBloc('Discord', ''),
      _generateTotpBloc('Amazon', ''),
      _generateTotpBloc('PayPal', ''),
    });
  }

  static TotpBloc _generateTotpBloc(String providerName, String accountName) {
    Uuid uuid = Uuid();

    TotpBloc totpBloc = TotpBloc();
    totpBloc.add(GenerateTotpCode());
    totpBloc.setTotpData(uuid.v4(), providerName, accountName, _randomSecret());

    return totpBloc;
  }

  static String _randomSecret() {
    final rand = Random.secure();
    String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return List.generate(8, (_) => chars[rand.nextInt(chars.length)])
        .join();
  }
}
