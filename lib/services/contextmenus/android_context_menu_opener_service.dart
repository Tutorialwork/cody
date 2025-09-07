import 'dart:io';

import 'package:cody/blocs/totp/totp_bloc.dart';
import 'package:cody/constants/style_constants.dart';
import 'package:cody/models/app_preference.dart';
import 'package:cody/models/context_menu_opener.dart';
import 'package:cody/services/app_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:haptic_feedback/haptic_feedback.dart';

import '../../widgets/account_code.dart';
import 'account_context_menu_service.dart';

class AndroidContextMenuOpenerService implements ContextMenuOpener {

  late ContextMenuItem selectedItem;
  AppPreferencesService appPreferencesService = GetIt.I<AppPreferencesService>();

  @override
  bool isPlatformMatching() {
    return Platform.isAndroid;
  }

  @override
  Widget getContextMenuWidget(BuildContext context, TotpCodeGenerated state, TotpBloc bloc) {
    return GestureDetector(
      onLongPressStart: (LongPressStartDetails details) {
        final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

        showMenu<ContextMenuItem>(
          context: context,
          position: RelativeRect.fromRect(
            details.globalPosition & const Size(40, 40), // Position the menu
            Offset.zero & overlay.size, // Size of the overlay
          ),
          items: [
            const PopupMenuItem<ContextMenuItem>(
              value: ContextMenuItem.editAccount,
              child: Row(
                children: [
                  Icon(Icons.edit),
                  horizontalSpacingSmall,
                  Text('Edit'),
                ],
              ),
            ),
            const PopupMenuItem<ContextMenuItem>(
              value: ContextMenuItem.deleteAccount,
              child: Row(
                children: [
                  Icon(Icons.delete),
                  horizontalSpacingSmall,
                  Text('Delete'),
                ],
              ),
            ),
          ],
        ).then((ContextMenuItem? selectedItem) {
          if (selectedItem != null) {
            switch (selectedItem) {
              case ContextMenuItem.editAccount:
                AccountContextMenuService.editAccount(null, context, state, bloc);
                break;
              case ContextMenuItem.deleteAccount:
                AccountContextMenuService.deleteAccount(null, context, state, bloc);
                break;
            }
          }
        });
      },
      child: SizedBox(
        width: 250,
        height: 150,
        child: GestureDetector(
          onTap: () async {
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

enum ContextMenuItem { editAccount, deleteAccount }
