class OtpauthParseException implements Exception {
  final String message;
  OtpauthParseException([this.message = 'Failed to parse otpauth url']);

  @override
  String toString() => 'OtpauthParseException: $message';
}