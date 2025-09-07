import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/style_constants.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _getPlatformLoader()
      ],
    );
  }

  Widget _getPlatformLoader() {
    return Platform.isIOS
        ? CupertinoActivityIndicator()
        : CircularProgressIndicator(
      color: primaryColor,
    );
  }
}
