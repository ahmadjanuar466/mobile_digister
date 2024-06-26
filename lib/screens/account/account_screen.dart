import 'package:digister/routes/route_helper.dart';
import 'package:digister/screens/account/components/setting_profile.dart';
import 'package:digister/screens/account/components/setting_section.dart';
import 'package:digister/screens/login/login_screen.dart';
import 'package:digister/services/firebase_api.dart';
import 'package:digister/themes/custom_theme.dart';
import 'package:digister/utils/global.dart';
import 'package:digister/widgets/theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:page_transition/page_transition.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  void _handleLogout() {
    showModalDialog(
      context,
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Apakah anda yakin ?'),
        actions: [
          TextButton(
            onPressed: () => RouteHelper.pop(context),
            child: const Text('Tidak'),
          ),
          TextButton(
            onPressed: () async {
              localStorage.removeItem('token');
              await FirebaseApi().firebaseMessaging.deleteToken();
              await FirebaseApi()
                  .firebaseMessaging
                  .unsubscribeFromTopic('payment');

              RouteHelper.pushAndRemoveUntil(
                // ignore: use_build_context_synchronously
                context,
                widget: const LoginScreen(isRegister: false),
                transitionType: PageTransitionType.leftToRight,
              );
            },
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Profil Saya',
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 20),
        const SettingProfile(),
        const SizedBox(height: 10),
        const Divider(),
        const SizedBox(height: 10),
        SettingSection(
          isDarkMode: isDarkMode,
          onChanged: (value) {
            setState(() {
              isDarkMode = value;
              if (isDarkMode) {
                theme = CustomTheme.darkTheme;
                localStorage.setItem('theme', 'dark');
              } else {
                theme = CustomTheme.lightTheme;
                localStorage.setItem('theme', 'light');
              }

              ThemeSwitcher.of(context)!.streamController.add(theme);
            });
          },
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _handleLogout,
          child: const Text('Keluar'),
        ),
        const SizedBox(height: 20),
        Center(
          child: Text(
            'Versi $appVersion',
            style: theme.textTheme.bodySmall!.copyWith(
              color: isDarkMode
                  ? theme.colorScheme.onPrimary.withOpacity(0.5)
                  : theme.colorScheme.secondary.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }
}
