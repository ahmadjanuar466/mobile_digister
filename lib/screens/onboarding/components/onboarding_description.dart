import 'package:digister/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OnboardingDescription extends StatelessWidget {
  const OnboardingDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lorem ipsum',
          style: theme.textTheme.titleLarge!.copyWith(
            fontSize: 35,
            color: theme.colorScheme.onPrimary,
          ),
        ),
        Text(
          "consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
          style: theme.textTheme.titleLarge!.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ].animate(interval: 600.ms).fadeIn(duration: 900.ms, delay: 300.ms).move(
            begin: const Offset(-16, 0),
            curve: Curves.easeOutQuad,
          ),
    );
  }
}
