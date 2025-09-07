import 'package:cody/constants/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class ExpirationCounter extends StatelessWidget {
  final double progress;
  final int secondsRemaining;

  const ExpirationCounter({super.key, required this.progress, required this.secondsRemaining});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 10,
            child: FAProgressBar(
              currentValue: progress,
              progressColor: primaryColor,
              animatedDuration: const Duration(milliseconds: 500),
            )
          ),
        ),
        horizontalSpacingMedium,
        Text("$secondsRemaining s")
      ],
    );
  }
}
