import 'package:flutter/material.dart';

class AndroidPasswordGeneratorInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onCopyButtonClick;

  const AndroidPasswordGeneratorInput(
      {super.key, required this.controller, required this.onCopyButtonClick});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      enableInteractiveSelection: true,
      decoration: InputDecoration(
        labelText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.copy),
          tooltip: 'Copy',
          onPressed: () => onCopyButtonClick(),
        ),
      ),
    );
  }
}
