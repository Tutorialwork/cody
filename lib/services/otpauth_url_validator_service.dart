import 'package:cody/models/otp_auth_url.dart';

class OtpAuthUrlValidatorService {

  void validateOrThrow(OtpAuthUrl otpAuthUrl) {
    if (otpAuthUrl.type != 'totp') {
      throw FormatException('Invalid OTP type: ${otpAuthUrl.type}');
    }

    if (otpAuthUrl.secret == null || otpAuthUrl.secret!.isEmpty) {
      throw FormatException('Missing secret');
    }

    final String? issuer = otpAuthUrl.labelIssuer ?? otpAuthUrl.parameterIssuer;
    if (issuer == null || issuer.isEmpty) {
      throw FormatException('Issuer missing (labelIssuer or parameterIssuer required)');
    }
  }

}