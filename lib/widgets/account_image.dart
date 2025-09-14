import 'dart:io';

import 'package:flutter/material.dart';

import 'loading.dart';

class AccountImage extends StatelessWidget {
  final String provider;

  static final double iconWidth = 35;

  const AccountImage({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return provider.isNotEmpty
        ? _getImageWidget()
        : Container();
  }

  Widget _getImageWidget() {
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      return Image.asset(
        _getLocalFaviconUrl(),
        width: iconWidth,
        height: iconWidth);
    }

    return Image.network(
      _getFaviconUrl(),
      loadingBuilder:
          (BuildContext context, Widget child, ImageChunkEvent? event) {
        if (event == null) {
          return child;
        }
        return SizedBox(
            width: iconWidth, height: iconWidth, child: Loading());
      },
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stacktrace) {
        return Image.asset(
          'assets/images/BlackCody.png',
          width: iconWidth,
          height: iconWidth,
        );
      },
      width: iconWidth,
      height: iconWidth,
    );
  }

  String _getFaviconUrl() {
    return 'https://$provider.com/favicon.ico';
  }

  String _getLocalFaviconUrl() {
    return 'assets/images/screenshots/icons/$provider.ico';
  }
}
