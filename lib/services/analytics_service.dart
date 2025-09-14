import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {

  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static void logEvent(String eventName, {Map<String, Object>? parameters}) {
    if (kDebugMode) {
      debugPrint('[Analytics] Logging event $eventName with parameters $parameters');
      return;
    }

    analytics.logEvent(name: eventName, parameters: parameters);
  }

  static void logScreen(String screenName, String screenClass) {
    if (kDebugMode) {
      debugPrint('[Analytics] Logging screen view of $screenName with class name $screenClass');
      return;
    }

    analytics.logScreenView(screenName: screenName, screenClass: screenClass);
  }

}