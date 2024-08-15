// ignore_for_file: use_build_context_synchronously

import 'package:digister/models/user_level_model.dart';
import 'package:digister/models/user_model.dart';
import 'package:digister/routes/route_helper.dart';
import 'package:digister/screens/login/login_screen.dart';
import 'package:digister/screens/security/home/home_screen.dart';
import 'package:digister/utils/image_constants.dart';
import 'package:digister/utils/jwt_decoder.dart';
import 'package:digister/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:geolocator/geolocator.dart';
import 'package:localstorage/localstorage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:digister/screens/basic/main/main_screen.dart';
import 'package:digister/screens/onboarding/onboarding_screen.dart';
import 'package:digister/utils/global.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void _nextScreen(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (isFirst == 1) {
      RouteHelper.pushReplacement(
        context,
        widget: const OnboardingScreen(),
        transitionType: PageTransitionType.rightToLeft,
      );
      return;
    }

    final token = localStorage.getItem('token');

    if (token == null) {
      RouteHelper.pushReplacement(
        context,
        widget: const LoginScreen(isRegister: false),
        transitionType: PageTransitionType.rightToLeft,
      );
      return;
    }

    if (JwtDecoder.isExpired(token)) {
      RouteHelper.pushReplacement(
        context,
        widget: const LoginScreen(isRegister: false),
        transitionType: PageTransitionType.rightToLeft,
      );
      return;
    }

    final payload = JwtDecoder.decodeJwt(token)['payload'];
    user = User.fromJson(payload['data']);
    userLevel = UserLevel.fromJson(payload['lvl']);

    if (userLevel.userLevelName != 'Security') {
      RouteHelper.pushReplacement(
        context,
        widget: const MainScreen(),
        transitionType: PageTransitionType.rightToLeft,
      );

      return;
    }

    RouteHelper.pushReplacement(
      context,
      widget: const HomeScreen(),
      transitionType: PageTransitionType.rightToLeft,
    );
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageAssets.logoImage,
              width: 120.adaptSize,
            ),
            Text(
              'Digister',
              style: theme.textTheme.titleLarge,
            ),
          ],
        ),
      )
          .animate(
            onComplete: (controller) => _nextScreen(context),
          )
          .fade(duration: 1.seconds),
    );
  }
}
