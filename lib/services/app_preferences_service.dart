import 'dart:convert';

import 'package:cody/models/app_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferencesService {

  final String key = 'appPreferences';
  final AppPreference defaultAppPreference = AppPreference(false, true);
  AppPreference? cachedAppPreferences;

  Future<AppPreference> loadAppPreferences() async {
    SharedPreferences instance = await SharedPreferences.getInstance();

    String? appPreferencesJson = instance.getString(key);
    if (appPreferencesJson == null) {
      return defaultAppPreference;
    }

    AppPreference appPreference = AppPreference.fromJson(jsonDecode(appPreferencesJson));
    cachedAppPreferences = appPreference;

    return appPreference;
  }

  Future<void> saveAppPreferences(AppPreference appPreferences) async {
    SharedPreferences instance = await SharedPreferences.getInstance();

    instance.setString(key, jsonEncode(appPreferences.toJson()));
    cachedAppPreferences = appPreferences;
  }

  AppPreference getCachedAppPreferences() {
    return cachedAppPreferences ?? defaultAppPreference;
  }
}