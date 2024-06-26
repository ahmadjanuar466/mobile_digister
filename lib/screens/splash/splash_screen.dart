import 'package:digister/models/user_level_model.dart';
import 'package:digister/models/user_model.dart';
import 'package:digister/routes/route_helper.dart';
import 'package:digister/screens/login/login_screen.dart';
import 'package:digister/utils/image_constants.dart';
import 'package:digister/utils/jwt_decoder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:localstorage/localstorage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:digister/screens/main/main_screen.dart';
import 'package:digister/screens/onboarding/onboarding_screen.dart';
import 'package:digister/utils/global.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void _nextScreen(BuildContext context) {
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
    user = UserModel.fromJson(payload['data']);
    userLevel = UserLevelModel.fromJson(payload['lvl']);

    RouteHelper.pushReplacement(
      context,
      widget: const MainScreen(),
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
              width: 120,
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
