import 'package:digister/screens/login/components/register_field.dart';
import 'package:digister/utils/global.dart';
import 'package:digister/utils/image_constants.dart';
import 'package:digister/utils/size_util.dart';
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
          padding: EdgeInsets.all(16.h),
          children: [
            SizedBox(height: !_isRegister ? 50.v : 25.v),
            Column(
              children: [
                Image.asset(
                  ImageAssets.logoImage,
                  width: 100.adaptSize,
                ),
                Text(
                  'Digister',
                  style: theme.textTheme.titleLarge,
                )
              ],
            ),
            SizedBox(height: 40.v),
            if (!_isRegister) const LoginField(),
            if (_isRegister) const RegisterField(),
            SizedBox(height: 10.v),
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
                  child: Text(!_isRegister ? 'Buat disini' : 'Masuk disini'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
