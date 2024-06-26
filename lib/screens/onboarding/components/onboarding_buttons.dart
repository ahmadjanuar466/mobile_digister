import 'package:digister/routes/route_helper.dart';
import 'package:digister/screens/login/login_screen.dart';
import 'package:digister/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class OnboardingButtons extends StatelessWidget {
  const OnboardingButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          onPressed: () => RouteHelper.pushReplacement(
            context,
            widget: const LoginScreen(isRegister: true),
            transitionType: PageTransitionType.rightToLeft,
          ),
          shape: ButtonShape.curved,
          text: 'MULAI',
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sudah punya akun ?',
              style: TextStyle(color: Colors.white),
            ),
            TextButton(
              onPressed: () => RouteHelper.pushReplacement(
                context,
                widget: const LoginScreen(isRegister: false),
                transitionType: PageTransitionType.rightToLeft,
              ),
              child: const Text('Masuk disini'),
            ),
          ],
        ),
      ],
    );
  }
}
