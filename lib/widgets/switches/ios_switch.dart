import 'package:cody/constants/style_constants.dart';
import 'package:flutter/cupertino.dart';

class IosSwitch extends StatelessWidget {

  final String label;
  final bool value;
  final Function(bool) onValueChange;
  final IconData? icon;

  const IosSwitch({super.key, required this.value, required this.label, required this.onValueChange, this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        (icon != null) ? Icon(icon) : Container(),
        (icon != null) ? horizontalSpacingSmall : Container(),
        Text(label, style: settingsLabelTextStyle,),
        Spacer(),
        CupertinoSwitch(
          value: value,
          onChanged: (bool? value) => onValueChange(value ?? false),
        ),
      ],
    );
  }
}
