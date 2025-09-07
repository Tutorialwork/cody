import 'package:flutter/material.dart';

import 'loading.dart';

class AccountImage extends StatelessWidget {
  final String provider;

  static final double iconWidth = 35;

  const AccountImage({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return provider.isNotEmpty
        ? Image.network(
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
          )
        : Container();
  }

  String _getFaviconUrl() {
    return 'https://$provider.com/favicon.ico';
  }
}
