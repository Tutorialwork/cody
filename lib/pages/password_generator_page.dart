import 'dart:math';

import 'package:cody/l10n/app_localizations.dart';
import 'package:cody/services/toast_service.dart';
import 'package:cody/widgets/page_title.dart';
import 'package:cody/widgets/password_generator_inputs/cody_password_generator_input.dart';
import 'package:cody/widgets/switches/cody_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:haptic_feedback/haptic_feedback.dart';

import '../constants/style_constants.dart';
import '../services/navigator_service.dart';

class PasswordGeneratorPage extends StatefulWidget {
  const PasswordGeneratorPage({super.key});

  @override
  State<PasswordGeneratorPage> createState() => _PasswordGeneratorPageState();
}

class _PasswordGeneratorPageState extends State<PasswordGeneratorPage> {

  final NavigatorService navigatorService = GetIt.I<NavigatorService>();
  final TextEditingController controller = TextEditingController();
  double passwordLength = 16;
  bool includeLowercase = true;
  bool includeUppercase = true;
  bool includeNumbers = true;
  bool includeSpecial = true;

  @override
  void initState() {
    controller.text = generatePassword(length: passwordLength.round());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: mediumSize),
      child: Column(
        children: [
          PageTitle(title: 'Generator'),
          SizedBox(
            height: mediumSize,
          ),
          CodyPasswordGeneratorInput(
              controller: controller,
              onCopyButtonClick: () => _copyPassword()),
          SizedBox(
            height: mediumSize,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Slider(
                  padding: EdgeInsets.all(0),
                  value: passwordLength,
                  min: 8,
                  max: 64,
                  divisions: 28,
                  activeColor: primaryColor,
                  label: passwordLength.round().toString(),
                  onChanged: (value) {
                    setState(() {
                      passwordLength = value;
                    });
                    _onGenerateNewPassword();
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.20,
                child: Padding(
                  padding: const EdgeInsets.all(smallSize),
                  child: Center(
                      child: Text(
                    passwordLength.round().toString(),
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  )),
                ),
              )
            ],
          ),
          SizedBox(
            height: mediumSize,
          ),
          CodySwitch(
              label: 'A - Z',
              value: includeUppercase,
              onValueChange: (bool newStatus) {
                if (isAllowedToDisableOption(newStatus)) {
                  return;
                }
                setState(() {
                  includeUppercase = newStatus;
                });
                _onGenerateNewPassword();
              }),
          CodySwitch(
              label: 'a - z',
              value: includeLowercase,
              onValueChange: (bool newStatus) {
                if (isAllowedToDisableOption(newStatus)) {
                  return;
                }
                setState(() {
                  includeLowercase = newStatus;
                });
                _onGenerateNewPassword();
              }),
          CodySwitch(
              label: '0 - 9',
              value: includeNumbers,
              onValueChange: (bool newStatus) {
                if (isAllowedToDisableOption(newStatus)) {
                  return;
                }
                setState(() {
                  includeNumbers = newStatus;
                });
                _onGenerateNewPassword();
              }),
          CodySwitch(
              label: '!@#\$%^&*',
              value: includeSpecial,
              onValueChange: (bool newStatus) {
                if (isAllowedToDisableOption(newStatus)) {
                  return;
                }
                setState(() {
                  includeSpecial = newStatus;
                });
                _onGenerateNewPassword();
              }),
          SizedBox(
            height: largeSize,
          ),
          ElevatedButton(
            onPressed: () => _onGenerateNewPassword(),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(
              AppLocalizations.of(context)!.label_generate_password_button,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          verticalSpacingMedium,
          GestureDetector(
            onTap: () => navigatorService.navigateTo('password/checker'),
            child: Text(
              AppLocalizations.of(context)!.label_check_password_security,
              style: secondaryLabelTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  bool isAllowedToDisableOption(bool newStatus) => !newStatus && _checkActivePasswordOptions() == 1;

  void _onGenerateNewPassword() {
    controller.text = generatePassword(
        length: passwordLength.round(),
        includeLowercase: includeLowercase,
        includeUppercase: includeUppercase,
        includeNumbers: includeNumbers,
        includeSpecial: includeSpecial);
  }

  String generatePassword({
    required int length,
    bool includeLowercase = true,
    bool includeUppercase = true,
    bool includeNumbers = true,
    bool includeSpecial = true,
  }) {
    const String lowercase = 'abcdefghijklmnopqrstuvwxyz';
    const String uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const String numbers = '0123456789';
    const String special = '!@#\$%^&*';

    String chars = '';
    if (includeLowercase) chars += lowercase;
    if (includeUppercase) chars += uppercase;
    if (includeNumbers) chars += numbers;
    if (includeSpecial) chars += special;

    if (chars.isEmpty) return '';

    final rand = Random.secure();
    return List.generate(length, (_) => chars[rand.nextInt(chars.length)])
        .join();
  }

  void _copyPassword() {
    Clipboard.setData(ClipboardData(text: controller.text));
    ToastService.showSuccessToast(AppLocalizations.of(context)!.toast_password_copied_to_clipboard);
    Haptics.vibrate(HapticsType.success);
  }

  int _checkActivePasswordOptions() {
    return [
      includeUppercase,
      includeLowercase,
      includeNumbers,
      includeSpecial,
    ].where((option) => option).length;
  }

}
