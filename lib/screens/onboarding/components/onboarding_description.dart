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
          'DIGISTER',
          style: theme.textTheme.titleLarge!.copyWith(
            fontSize: 30,
            color: theme.colorScheme.onPrimary,
          ),
        ),
        Text(
          "Memudahkan anda dalam melakukan layanan kemasyarakatan.",
          style: theme.textTheme.titleMedium!.copyWith(
            fontSize: 18,
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
