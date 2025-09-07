import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class LeakedPasswordCheckerService {
  static const String apiBaseUrl = "https://api.pwnedpasswords.com";

  Future<int> getLeakedCounterByPassword(String sha1Hash) async {
    String hashFirstSegment = sha1Hash.substring(0, 5);
    String hashLastSegment = sha1Hash.substring(5);

    Uri requestUri = Uri.parse('${apiBaseUrl}/range/${hashFirstSegment}');
    Response response = await http.get(requestUri);

    List<String> entries = response.body.split('\n');

    List<String> matches = entries.where((String entry) => isEntryMatchingPassword(entry, hashLastSegment)).toList();

    if (matches.isEmpty) {
      return 0;
    }

    return int.parse(matches.first.split(':').last);
  }

  bool isEntryMatchingPassword(String entry, String hashLastSegment) {
    return entry.split(':').first.toLowerCase() == hashLastSegment;
  }

  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha1.convert(bytes);
    return digest.toString();
  }
}
