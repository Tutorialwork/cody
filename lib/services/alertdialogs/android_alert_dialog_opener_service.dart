import 'dart:io';

import 'package:cody/models/alert_dialog_opener.dart';
import 'package:flutter/material.dart';

import '../../models/alert_dialog_content.dart';

class AndroidAlertDialogOpenerService implements AlertDialogOpener {

  @override
  bool isPlatformMatching() {
    return Platform.isAndroid;
  }

  @override
  void openQuestionDialog(BuildContext context, AlertDialogContent alertContent, Function(BuildContext) onCancel, Function(BuildContext) onConfirm) {
    showDialog<String>(
      context: context,
      builder:
          (BuildContext alertContext) => AlertDialog(
        title: Text(alertContent.title),
        content: Text(alertContent.content),
        actions: <Widget>[
          TextButton(
            onPressed: () => onCancel(alertContext),
            child: Text(alertContent.cancelLabel),
          ),
          TextButton(
            onPressed: () => onConfirm(alertContext),
            child: Text(alertContent.confirmLabel),
          ),
        ],
      ),
    );
  }

  @override
  void openInformationDialog(BuildContext context, AlertDialogContent alertContent, Function(BuildContext) onClose) {
    showDialog<String>(
      context: context,
      builder:
          (BuildContext alertContext) => AlertDialog(
        title: Text(alertContent.title),
        content: Text(alertContent.content),
        actions: <Widget>[
          TextButton(
            onPressed: () => onClose(alertContext),
            child: Text(alertContent.cancelLabel),
          ),
        ],
      ),
    );
  }

}