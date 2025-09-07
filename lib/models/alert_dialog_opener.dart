import 'package:cody/models/alert_dialog_content.dart';
import 'package:flutter/cupertino.dart';

abstract class AlertDialogOpener {

  bool isPlatformMatching();

  void openQuestionDialog(BuildContext context, AlertDialogContent content, Function(BuildContext) onCancel, Function(BuildContext) onConfirm);

  void openInformationDialog(BuildContext context, AlertDialogContent content, Function(BuildContext) onClose);

}