import 'package:digister/routes/route_helper.dart';
import 'package:digister/services/auth.dart';
import 'package:digister/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:localstorage/localstorage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:digister/screens/forgotPassword/forgot_password_screen.dart';
import '../../main/main_screen.dart';

class LoginField extends StatefulWidget {
  const LoginField({super.key});

  @override
  State<LoginField> createState() => _LoginFieldState();
}

class _LoginFieldState extends State<LoginField> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      showLoader(context, "Login. Mohon tunggu");

      final body = {
        'email': _emailController.text,
        'password': _passwordController.text,
      };

      final login = await doLogin(body);

      // ignore: use_build_context_synchronously
      Navigator.pop(context);

      if (login) {
        localStorage.setItem('isFirst', '0');
        Future.delayed(const Duration(seconds: 1), () {
          RouteHelper.pushAndRemoveUntil(
            context,
            widget: const MainScreen(),
            transitionType: PageTransitionType.rightToLeft,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ...[
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              validator: validator,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  icon: Icon(
                    !_isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
              validator: validator,
            ),
          ]
              .animate(interval: 100.ms)
              .fadeIn(duration: 200.ms, delay: 100.ms)
              .move(
                begin: const Offset(-16, 0),
                curve: Curves.easeOutQuad,
              ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => RouteHelper.push(
                context,
                widget: const ForgotPasswordScreen(),
                transitionType: PageTransitionType.rightToLeft,
              ),
              child: const Text(
                "Lupa kata sandi ?",
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 45,
            child: ElevatedButton(
              onPressed: _handleLogin,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.login_rounded),
                  SizedBox(width: 4.0),
                  Text('Masuk'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
