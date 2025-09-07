import 'dart:io';

import 'package:cody/models/app_preference.dart';
import 'package:cody/services/app_preferences_service.dart';
import 'package:cody/widgets/page_title.dart';
import 'package:cody/widgets/switches/cody_switch.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/style_constants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final AppPreferencesService service = GetIt.I<AppPreferencesService>();
  late AppPreference appPreference = service.getCachedAppPreferences();
  PackageInfo? packageInfo;

  @override
  void initState() {
    _loadPackageInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: mediumSize),
      child: Column(
        children: [
          PageTitle(title: 'Settings'),
          verticalSpacingMedium,
          CodySwitch(label: 'App Authentication', value: appPreference.isAppAuthenticationEnabled, onValueChange: (bool newValue) {
            appPreference.isAppAuthenticationEnabled = newValue;
            _updateAppPreferences(appPreference);
            _updateUI();
          }, icon: Icons.lock,),
          getDivider(),
          CodySwitch(label: 'Show Account Names', value: appPreference.shouldShowAccountName, onValueChange: (bool newValue) {
            appPreference.shouldShowAccountName = newValue;
            _updateAppPreferences(appPreference);
            _updateUI();
          }, icon: Icons.label,),
          getDivider(),
          GestureDetector(
            onTap: _openAppReviewPage,
            child: Row(
              children: [
                Icon(Icons.star),
                horizontalSpacingMedium,
                Text('Write review', style: settingsLabelTextStyle,),
                Spacer(),
                Icon(Icons.arrow_forward_ios, color: Colors.blueGrey,)
              ],
            ),
          ),
          Spacer(),
          (packageInfo != null) ? Text('Version ${packageInfo!.version} (${packageInfo!.buildNumber})', style: secondaryTextStyle,) : Container(),
          Text('Developed by Manuel Schuler', style: secondaryTextStyle,),
          verticalSpacingXLarge
        ],
      ),
    );
  }

  Future<void> _updateAppPreferences(AppPreference appPreferences) async {
    await service.saveAppPreferences(appPreferences);
  }

  void _updateUI() {
    setState(() {

    });
  }

  Widget getDivider() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Divider(
        color: Colors.grey,
        thickness: 0.3,
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
    );
  }

  Future<void> _loadPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    _updateUI();
  }

  Future<void> _openAppReviewPage() async {
    if (Platform.isIOS) {
      await launchUrl(Uri.parse('itms-apps://itunes.apple.com/app/id/1580806194?ls=1&mt=8&action=write-review'), mode: LaunchMode.externalApplication);
    } else {
      await launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=dev.tutorialwork.Cody'), mode: LaunchMode.externalApplication);
    }
  }
}
