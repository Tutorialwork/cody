import 'package:cody/constants/style_constants.dart';
import 'package:flutter/material.dart';

class AndroidSwitch extends StatelessWidget {

  final String label;
  final bool value;
  final Function(bool) onValueChange;
  final IconData? icon;

  const AndroidSwitch({super.key, required this.value, required this.label, required this.onValueChange, this.icon});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(label, style: settingsLabelTextStyle,),
      value: value,
      onChanged: (bool? value) => onValueChange(value ?? false),
      secondary: icon != null ? Icon(icon) : null,
      contentPadding: EdgeInsets.all(0),
      activeColor: primaryColor,
    );
  }
}
