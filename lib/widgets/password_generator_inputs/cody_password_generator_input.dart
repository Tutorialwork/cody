import 'dart:io';

import 'package:cody/widgets/password_generator_inputs/android_password_generator_input.dart';
import 'package:cody/widgets/password_generator_inputs/ios_password_generator_input.dart';
import 'package:flutter/material.dart';

class CodyPasswordGeneratorInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onCopyButtonClick;

  const CodyPasswordGeneratorInput(
      {super.key, required this.controller, required this.onCopyButtonClick});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? IosPasswordGeneratorInput(
            controller: controller, onCopyButtonClick: onCopyButtonClick)
        : AndroidPasswordGeneratorInput(
            controller: controller, onCopyButtonClick: onCopyButtonClick);
  }
}
