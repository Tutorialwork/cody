import 'dart:io';

import 'package:cody/models/alert_dialog_opener.dart';
import 'package:flutter/cupertino.dart';

import '../../models/alert_dialog_content.dart';

class IosAlertDialogOpenerService implements AlertDialogOpener {

  @override
  bool isPlatformMatching() {
    return Platform.isIOS;
  }

  @override
  void openQuestionDialog(BuildContext context, AlertDialogContent alertContent, Function(BuildContext) onCancel, Function(BuildContext) onConfirm) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext alertContext) => CupertinoAlertDialog(
        title: Text(alertContent.title),
        content: Text(alertContent.content),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => onCancel(alertContext),
            child: Text(alertContent.cancelLabel),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => onConfirm(alertContext),
            child: Text(alertContent.confirmLabel),
          ),
        ],
      ),
    );
  }

  @override
  void openInformationDialog(BuildContext context, AlertDialogContent alertContent, Function(BuildContext) onClose) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext alertContext) => CupertinoAlertDialog(
        title: Text(alertContent.title),
        content: Text(alertContent.content),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => onClose(alertContext),
            child: Text(alertContent.cancelLabel),
          ),
        ],
      ),
    );
  }

}