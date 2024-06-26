import 'package:flutter/material.dart';
import 'package:digister/screens/forgotPassword/components/nik_field.dart';
import 'package:digister/screens/forgotPassword/components/password_field.dart';
import '../../utils/global.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    isDarkMode = theme.brightness == Brightness.dark;

    return ListenableBuilder(
      listenable: forgotPasswordModel,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                forgotPasswordModel.changeState({
                  "title": "Lupa Sandi",
                  "description":
                      "Silahkan masukkan NIK yang anda gunakan di akun anda. Sistem kami akan mengecek NIK anda agar dapat melakukan perubahan kata sandi.",
                  "isChangingPassword": false,
                });

                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
            title: Text(forgotPasswordModel.screenState['title']),
          ),
          body: PopScope(
            onPopInvoked: (didPop) {
              forgotPasswordModel.changeState({
                "title": "Lupa Sandi",
                "description":
                    "Silahkan masukkan NIK yang anda gunakan di akun anda. Sistem kami akan mengecek NIK anda agar dapat melakukan perubahan kata sandi.",
                "isChangingPassword": false,
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    forgotPasswordModel.screenState['description'],
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20),
                  forgotPasswordModel.screenState['isChangingPassword']
                      ? Expanded(
                          child: PasswordField(nik: forgotPasswordModel.nik),
                        )
                      : const Expanded(child: NIKField()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
