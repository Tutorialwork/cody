import 'dart:io';

import 'package:cody/l10n/app_localizations.dart';
import 'package:cody/models/app_preference.dart';
import 'package:cody/services/app_preferences_service.dart';
import 'package:cody/widgets/page_title.dart';
import 'package:cody/widgets/switches/cody_switch.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/style_constants.dart';
import '../services/analytics_service.dart';

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
    AnalyticsService.logScreen('Settings', (SettingsPage).toString());

    _loadPackageInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: mediumSize),
      child: Column(
        children: [
          PageTitle(title: AppLocalizations.of(context)!.settings_title),
          verticalSpacingMedium,
          CodySwitch(label: AppLocalizations.of(context)!.label_app_authentication, value: appPreference.isAppAuthenticationEnabled, onValueChange: (bool newValue) {
            appPreference.isAppAuthenticationEnabled = newValue;
            _updateAppPreferences(appPreference);
            _updateUI();
          }, icon: Icons.lock,),
          getDivider(),
          CodySwitch(label: AppLocalizations.of(context)!.label_show_account_names, value: appPreference.shouldShowAccountName, onValueChange: (bool newValue) {
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
                Text(AppLocalizations.of(context)!.label_write_review, style: settingsLabelTextStyle,),
                Spacer(),
                Icon(Icons.arrow_forward_ios, color: Colors.blueGrey,)
              ],
            ),
          ),
          Spacer(),
          (packageInfo != null) ? Text('Version ${packageInfo!.version} (${packageInfo!.buildNumber})', style: secondaryTextStyle,) : Container(),
          Text(AppLocalizations.of(context)!.label_developed_by, style: secondaryTextStyle,),
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
