import 'package:flutter/cupertino.dart';

import '../../constants/style_constants.dart';

class IosPasswordGeneratorInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onCopyButtonClick;

  const IosPasswordGeneratorInput({super.key, required this.controller, required this.onCopyButtonClick});

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      readOnly: true,
      enableInteractiveSelection: true,
      placeholder: "Password",
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: CupertinoColors.systemGrey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      suffix: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Icon(
          CupertinoIcons.doc_on_doc,
          size: 20,
          color: primaryColor,
        ),
        onPressed: () => onCopyButtonClick(),
      ),
    );
  }
}
