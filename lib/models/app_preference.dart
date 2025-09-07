class AppPreference {

  bool isAppAuthenticationEnabled;
  bool shouldShowAccountName;

  AppPreference(this.isAppAuthenticationEnabled, this.shouldShowAccountName);

  Map<String, dynamic> toJson() =>
      {'isAppAuthenticationEnabled': isAppAuthenticationEnabled, 'shouldShowAccountName': shouldShowAccountName};

  static AppPreference fromJson(Map<String, dynamic> json) =>
      AppPreference(json['isAppAuthenticationEnabled'], json['shouldShowAccountName']);

  @override
  String toString() {
    return 'AppPreference{isAppAuthenticationEnabled: $isAppAuthenticationEnabled, shouldShowAccountName: $shouldShowAccountName}';
  }

}