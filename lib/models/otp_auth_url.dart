class OtpAuthUrl {
  final String type;
  final String labelIssuer;
  final String? accountName;
  final String? secret;
  final String? parameterIssuer;
  final String? algorithm;
  final String? digits;
  final String? period;

  OtpAuthUrl(this.type, this.labelIssuer, this.accountName, this.secret,
      this.parameterIssuer, this.algorithm, this.digits, this.period);

  @override
  String toString() {
    return 'OtpAuthUrl{type: $type, labelIssuer: $labelIssuer, accountName: $accountName, secret: $secret, parameterIssuer: $parameterIssuer, algorithm: $algorithm, digits: $digits, period: $period}';
  }
}
