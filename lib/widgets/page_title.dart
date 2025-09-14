import 'package:cody/services/navigator_service.dart';
import 'package:cody/widgets/settings_icon.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../constants/style_constants.dart';

class PageTitle extends StatelessWidget {

  NavigatorService navigatorService = GetIt.I<NavigatorService>();

  final String title;
  final bool hasBackButton;
  final bool showSettingsIcon;

  PageTitle({super.key, required this.title, this.hasBackButton = false, this.showSettingsIcon = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: mediumSize),
        child: Column(children: [
          showSettingsIcon ? SettingsIcon() : Container(),
          hasBackButton
              ? _getTitleWithBackButton(context)
              : _getTitleWithoutBackButton(context),
          const SizedBox(
            height: mediumSize,
          )
        ]));
  }

  Widget _getTitleWithBackButton(BuildContext context) {
    return Row(
      children: [
        InkWell(
            onTap: () => navigatorService.navigateTo(navigatorService.previousRoute),
            child: Icon(Icons.arrow_back_ios)),
        horizontalSpacingSmall,
        Expanded(
          child: Text(
            title,
            style: pageHeadingTextStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _getTitleWithoutBackButton(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Text(
          title,
          style: pageHeadingTextStyle,
          overflow: TextOverflow.ellipsis,
        ));
  }
}
