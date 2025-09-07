import 'dart:io';

import 'package:cody/widgets/switches/android_switch.dart';
import 'package:cody/widgets/switches/ios_switch.dart';
import 'package:flutter/cupertino.dart';

class CodySwitch extends StatelessWidget {
  final String label;
  final bool value;
  final Function(bool) onValueChange;
  final IconData? icon;

  const CodySwitch(
      {super.key,
      required this.label,
      required this.value,
      required this.onValueChange,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? IosSwitch(value: value, label: label, onValueChange: onValueChange, icon: icon,)
        : AndroidSwitch(
            value: value, label: label, onValueChange: onValueChange, icon: icon,);
  }
}
