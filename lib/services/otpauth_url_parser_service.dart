import 'package:cody/exceptions/otpauth_parse_exception.dart';
import 'package:cody/models/otp_auth_url.dart';

class OtpAuthUrlParserService {
  static OtpAuthUrl parse(String otpauthUrl) {
    Uri otpauthUri = Uri.parse(otpauthUrl);

    if (otpauthUri.scheme != 'otpauth') {
      throw OtpauthParseException('No otpauth url');
    }

    final String firstPathSegment = otpauthUri.pathSegments[0];
    final bool containsIssuer = firstPathSegment.contains(':');
    final List<String> firstPathSegmentParts = firstPathSegment.split(':');

    return OtpAuthUrl(
        otpauthUri.host,
        containsIssuer ? firstPathSegmentParts[0] : firstPathSegment,
        containsIssuer ? firstPathSegmentParts[1] : null,
        otpauthUri.queryParameters['secret'],
        otpauthUri.queryParameters['issuer'],
        otpauthUri.queryParameters['algorithm'],
        otpauthUri.queryParameters['digits'],
        otpauthUri.queryParameters['period']);
  }
}
