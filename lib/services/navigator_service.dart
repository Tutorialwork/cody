import 'package:flutter/cupertino.dart';

class NavigatorService {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  String currentActiveRoute = 'codes';
  String previousRoute = '';

  void navigateTo(String routeName, [Object? arguments]) {
    previousRoute = currentActiveRoute;
    currentActiveRoute = routeName;
    navigatorKey.currentState?.pushNamedAndRemoveUntil(routeName, (Route route) => route.isFirst, arguments: arguments);
  }

}
