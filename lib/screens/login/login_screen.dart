import 'package:digister/screens/login/components/register_field.dart';
import 'package:digister/utils/global.dart';
import 'package:digister/utils/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:digister/screens/login/components/login_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.isRegister});

  final bool isRegister;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isRegister = false;

  @override
  void initState() {
    super.initState();
    _isRegister = widget.isRegister;
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SizedBox(height: !_isRegister ? 50 : 25),
            Column(
              children: [
                Image.asset(
                  ImageAssets.logoImage,
                  width: 100,
                ),
                Text(
                  'Digister',
                  style: theme.textTheme.titleLarge,
                )
              ],
            ),
            const SizedBox(height: 40),
            if (!_isRegister) const LoginField(),
            if (_isRegister) const RegisterField(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  !_isRegister ? 'Belum punya akun ?' : 'Sudah punya akun ?',
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isRegister = !_isRegister;
                    });
                  },
                  child: Text(!_isRegister ? 'Daftar disini' : 'Masuk disini'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
