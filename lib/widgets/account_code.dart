import 'package:cody/constants/style_constants.dart';
import 'package:cody/widgets/account_image.dart';
import 'package:flutter/material.dart';

class AccountCode extends StatelessWidget {
  final String name;
  final String accountName;
  final String code;
  final bool shouldShowAccountName;

  const AccountCode(
      {super.key,
      required this.code,
      required this.name,
      required this.accountName,
      required this.shouldShowAccountName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: smallSize),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              horizontalSpacingSmall,
              AccountImage(provider: name),
              horizontalSpacingSmall,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: accountNameTextStyle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    accountName.isNotEmpty && shouldShowAccountName
                        ? Text(
                      accountName,
                      style: secondaryTextStyle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )
                        : Container(),
                  ],
                ),
              )
            ],
          ),
          verticalSpacingMedium,
          Text(
            _formatCode(code),
            style: codeTextStyle,
          ),
        ],
      ),
    );
  }

  String _formatCode(String code) {
    String firstThreeDigits = code.substring(0, 3);
    String lastThreeDigits = code.substring(3, 6);

    return "$firstThreeDigits $lastThreeDigits";
  }
}
