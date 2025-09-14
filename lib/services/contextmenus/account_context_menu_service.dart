import 'package:cody/blocs/totp/totp_bloc.dart';
import 'package:cody/l10n/app_localizations.dart';
import 'package:cody/models/arguments/edit_account_page_arguments.dart';
import 'package:cody/services/accounts_data_service.dart';
import 'package:cody/services/navigator_service.dart';
import 'package:cody/services/toast_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:haptic_feedback/haptic_feedback.dart';

import '../../constants/list_constants.dart';
import '../../models/account.dart';
import '../../models/alert_dialog_content.dart';
import '../../models/alert_dialog_opener.dart';
import '../../models/storage.dart';

class AccountContextMenuService {

  static final AccountsDataService dataService = GetIt.I<AccountsDataService>();
  static final NavigatorService navigatorService = GetIt.I<NavigatorService>();

  static void editAccount(BuildContext? menuContext, BuildContext context, TotpCodeGenerated state, TotpBloc bloc) {
    if (menuContext != null) {
      Navigator.pop(menuContext);
    }

    EditAccountPageArguments arguments = EditAccountPageArguments(
        state.toAccount(),
        (Account newAccount) => _onUpdateAccount(context, bloc, state, newAccount));

    navigatorService.navigateTo('codes/edit', arguments);
  }

  static void deleteAccount(BuildContext? menuContext, BuildContext context, TotpCodeGenerated state, TotpBloc bloc) {
    if (menuContext != null) {
      Navigator.pop(menuContext);
    }

    AlertDialogOpener opener = ListsConstants.alertDialogOpeners.where((AlertDialogOpener opener) => opener.isPlatformMatching()).toList().first;
    opener.openQuestionDialog(
        context,
        AlertDialogContent(
            AppLocalizations.of(context)!.question_deleting_account_title,
            AppLocalizations.of(context)!.question_deleting_account_message,
            AppLocalizations.of(context)!.label_deleting_account_confirm,
            AppLocalizations.of(context)!.label_deleting_account_cancel),
            (BuildContext alertContext) => Navigator.pop(alertContext),
            (BuildContext alertContext) => _onDeleteDialogConfirm(alertContext, state, bloc));
  }

  static Future<void> _onUpdateAccount(BuildContext context, TotpBloc bloc, TotpCodeGenerated state, Account newAccount) async {
    for (Storage storage in ListsConstants.storageServices) {
      await storage.removeAccount(state.toAccount());
      await storage.saveAccount(newAccount);
    }

    dataService.updateStream.add(null);
    navigatorService.navigateTo('codes');
  }

  static Future<void> _onDeleteDialogConfirm(BuildContext alertContext, TotpState state, TotpBloc bloc) async {
    Navigator.pop(alertContext);

    TotpCodeGenerated codeGenerated = state as TotpCodeGenerated;

    Account account = codeGenerated.toAccount();
    for (Storage service in ListsConstants.storageServices) {
      await service.removeAccount(account);
    }

    ToastService.showSuccessToast('${state.provider} deleted!');
    Haptics.vibrate(HapticsType.success);

    dataService.accounts.remove(bloc);
    dataService.updateStream.add(null);
  }

}