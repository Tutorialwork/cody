import 'dart:io';

import 'package:cody/constants/analytics_event_names_constants.dart';
import 'package:cody/models/context_menu_opener.dart';
import 'package:cody/services/analytics_service.dart';
import 'package:cody/services/contextmenus/account_context_menu_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:haptic_feedback/haptic_feedback.dart';

import '../../blocs/totp/totp_bloc.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/account_code.dart';
import '../app_preferences_service.dart';

class IosContextMenuOpenerService implements ContextMenuOpener {

  AppPreferencesService appPreferencesService = GetIt.I<AppPreferencesService>();

  @override
  bool isPlatformMatching() {
    return Platform.isIOS;
  }

  @override
  Widget getContextMenuWidget(BuildContext context, TotpCodeGenerated state, TotpBloc bloc) {
    return CupertinoContextMenu(
      actions: [
        Builder(
            builder: (BuildContext menuContext) => CupertinoContextMenuAction(
              onPressed: () => AccountContextMenuService.editAccount(menuContext, context, state, bloc),
              trailingIcon: CupertinoIcons.pencil,
              child: Text(AppLocalizations.of(context)!.edit),
            )
        ),
        Builder(builder: (BuildContext menuContext) => CupertinoContextMenuAction(
          onPressed: () => AccountContextMenuService.deleteAccount(menuContext, context, state, bloc),
          isDestructiveAction: true,
          trailingIcon: CupertinoIcons.delete,
          child: Text(AppLocalizations.of(context)!.delete),
        )),
      ],
      child: SizedBox(
        width: 250,
        height: 150,
        child: GestureDetector(
          onTap: () async {
            AnalyticsService.logEvent(AnalyticsEventNamesConstants.copyAccountCode);
            Clipboard.setData(ClipboardData(text: state.code));
            await Haptics.vibrate(HapticsType.success);
          },
          child: AccountCode(
            name: state.provider,
            code: state.code,
            accountName: state.accountName,
            shouldShowAccountName: appPreferencesService.getCachedAppPreferences().shouldShowAccountName,
          ),
        ),
      ),
    );
  }

}