import 'package:cody/constants/style_constants.dart';
import 'package:cody/services/navigator_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SettingsIcon extends StatelessWidget {

  final NavigatorService service = GetIt.I<NavigatorService>();

  SettingsIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
            onTap: _onOpenSettingsPage,
            child: Icon(CupertinoIcons.gear, size: 40, color: _isSettingsPageActive() ? primaryColor : Colors.black))
      ],
    );
  }

  void _onOpenSettingsPage() {
    if (service.currentActiveRoute == 'settings') {
      return;
    }
    service.navigateTo('settings');
  }

  bool _isSettingsPageActive() {
    return service.currentActiveRoute == 'settings';
  }
}
