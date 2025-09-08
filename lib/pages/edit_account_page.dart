import 'package:cody/constants/list_constants.dart';
import 'package:cody/constants/style_constants.dart';
import 'package:cody/models/account.dart';
import 'package:cody/models/alert_dialog_content.dart';
import 'package:cody/widgets/loading.dart';
import 'package:cody/widgets/page_title.dart';
import 'package:flutter/cupertino.dart';

import '../models/alert_dialog_opener.dart';

class EditAccountPage extends StatefulWidget {

  final Account account;
  final Function(Account) onSave;

  const EditAccountPage({super.key, required this.account, required this.onSave});

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {

  bool isLoading = false;

  final TextEditingController providerController = TextEditingController();
  final TextEditingController accountNameController = TextEditingController();


  @override
  void initState() {
    setState(() {
      providerController.text = widget.account.provider;
      accountNameController.text = widget.account.accountName;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (!isLoading) ? Container(
      padding: const EdgeInsets.all(mediumSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageTitle(title: 'Edit account', hasBackButton: true, showSettingsIcon: false,),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Provider', style: secondaryTextStyle),
                CupertinoTextField(
                  controller: providerController,
                  placeholder: 'Provider',
                ),
                verticalSpacingSmall,
                Text('Account name', style: secondaryTextStyle),
                CupertinoTextField(
                  controller: accountNameController,
                  placeholder: 'Account name',
                ),
                verticalSpacingLarge,
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CupertinoButton.filled(
                    onPressed: () => _onSave(),
                    child: Text('Save'),
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ) : Loading();
  }

  void _onSave() {
    String newProvider = providerController.text;
    String newAccountName = accountNameController.text;

    if (newProvider.isEmpty) {
      AlertDialogOpener opener = ListsConstants.alertDialogOpeners.where((AlertDialogOpener opener) => opener.isPlatformMatching()).toList().first;
      opener.openInformationDialog(context, AlertDialogContent('Error', 'Provider field must be filled', '', 'Okay'), (BuildContext context) => Navigator.pop(context));

      return;
    }

    setState(() {
      isLoading = true;
    });

    Account newAccount = Account(widget.account.id, newProvider, newAccountName, widget.account.secret, true, DateTime.now());
    widget.onSave(newAccount);
  }
}
