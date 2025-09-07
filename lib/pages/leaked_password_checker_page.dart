import 'package:cody/services/leaked_password_checker_service.dart';
import 'package:cody/services/toast_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../constants/style_constants.dart';
import '../widgets/page_title.dart';

class LeakedPasswordCheckerPage extends StatefulWidget {
  const LeakedPasswordCheckerPage({super.key});

  @override
  State<LeakedPasswordCheckerPage> createState() =>
      _LeakedPasswordCheckerPageState();
}

class _LeakedPasswordCheckerPageState extends State<LeakedPasswordCheckerPage> {
  final TextEditingController controller = TextEditingController();

  final LeakedPasswordCheckerService service = LeakedPasswordCheckerService();

  int? passwordLeakedCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: mediumSize),
      child: Column(
        children: [
          PageTitle(
            title: 'Password checker',
            hasBackButton: true,
          ),
          SizedBox(
            height: mediumSize,
          ),
          TextField(
            controller: controller,
            enableInteractiveSelection: true,
            decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12), // Rounded corners
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.done),
                tooltip: 'Test',
                onPressed: () async {
                  if (controller.text.isEmpty) {
                    ToastService.showFailureToast('Password can\'t be empty.');
                    return;
                  }

                  int counter = await service.getLeakedCounterByPassword(
                      service.hashPassword(controller.text));
                  setState(() {
                    passwordLeakedCount = counter;
                  });
                },
              ),
            ),
          ),
          SizedBox(
            height: mediumSize,
          ),
          _getResponseWidget()
        ],
      ),
    );
  }

  Widget _getResponseWidget() {
    int? leakedCounter = passwordLeakedCount;

    if (leakedCounter == null) {
      return Container();
    }

    if (leakedCounter > 0) {
      return _getNegativeResponse();
    }

    return _getPositiveResponse();
  }

  Widget _getNegativeResponse() {
    return Column(
      children: [
        Icon(
          Icons.close,
          size: 60,
          color: Colors.red,
        ),
        SizedBox(
          height: smallSize,
        ),
        Text(
          'This password was found in ${NumberFormat.decimalPattern().format(passwordLeakedCount)} known data breaches.',
          style: codeTextStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _getPositiveResponse() {
    return Column(
      children: [
        Icon(
          Icons.done,
          size: 60,
          color: Colors.green,
        ),
        SizedBox(
          height: smallSize,
        ),
        Text(
          'This password was never found in any known data breach.',
          style: codeTextStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
