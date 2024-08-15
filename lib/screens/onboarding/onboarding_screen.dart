import 'package:digister/screens/onboarding/components/onboarding_buttons.dart';
import 'package:digister/screens/onboarding/components/onboarding_description.dart';
import 'package:digister/utils/global.dart';
import 'package:digister/utils/image_constants.dart';
import 'package:digister/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage(ImageAssets.housingImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(16.h),
          color: Colors.black45,
          child: SafeArea(
            child: Column(
              children: [
                Image.asset(
                  ImageAssets.logoImage,
                  width: 150.adaptSize,
                ),
                const Spacer(),
                const OnboardingDescription(),
                SizedBox(height: 20.v),
                const OnboardingButtons()
              ].animate(interval: 200.ms).fadeIn(duration: 500.ms),
            ),
          ),
        ),
      ),
    );
  }
}
