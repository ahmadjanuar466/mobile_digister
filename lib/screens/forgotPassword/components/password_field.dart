import 'package:digister/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:digister/widgets/custom_button.dart';
import '../../../utils/global.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, required this.nik});

  final String nik;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  _handleChangePassword() async {
    if (_formKey.currentState!.validate()) {
      showLoader(context, "Merubah password");

      final passwordReset = await resetPassword({
        'nik': widget.nik,
        'password': _confirmPasswordController.text,
      });

      // ignore: use_build_context_synchronously
      Navigator.pop(context);

      if (passwordReset) {
        forgotPasswordModel.changeState({
          "title": "Lupa Sandi",
          "description":
              "Silahkan masukkan NIK yang anda gunakan di akun anda. Sistem kami akan mengecek NIK anda agar dapat melakukan perubahan kata sandi.",
          "isChangingPassword": false,
        });

        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: !_showPassword,
            decoration: InputDecoration(
              labelText: 'Password baru',
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
                icon: Icon(
                  _showPassword
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                ),
              ),
            ),
            validator: validator,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _confirmPasswordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: !_showConfirmPassword,
            decoration: InputDecoration(
              labelText: 'Konfirmasi password baru',
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _showConfirmPassword = !_showConfirmPassword;
                  });
                },
                icon: Icon(
                  _showConfirmPassword
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                ),
              ),
            ),
            validator: (value) {
              if (value == "" || value!.isEmpty) {
                return "Wajib diisi";
              } else if (value != _passwordController.text) {
                return "Konfirmasi password baru harus sama";
              }

              return null;
            },
          ),
          const Spacer(),
          CustomButton(
            text: "Ubah Password",
            onPressed: _handleChangePassword,
          ),
        ],
      ),
    );
  }
}
