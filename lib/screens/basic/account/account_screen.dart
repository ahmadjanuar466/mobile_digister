import 'package:digister/routes/route_helper.dart';
import 'package:digister/screens/basic/account/components/setting_profile.dart';
import 'package:digister/screens/basic/account/components/setting_section.dart';
import 'package:digister/screens/login/login_screen.dart';
import 'package:digister/services/firebase_api.dart';
import 'package:digister/themes/custom_theme.dart';
import 'package:digister/utils/global.dart';
import 'package:digister/utils/size_util.dart';
import 'package:digister/widgets/theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:page_transition/page_transition.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String _appVersion = '';

  @override
  void initState() {
    super.initState();
    _getAppVersion();
  }

  void _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = packageInfo.version;
    });
  }

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
              showLoader(context);

              localStorage.removeItem('token');
              await FirebaseApi().firebaseMessaging.deleteToken();
              await FirebaseApi()
                  .firebaseMessaging
                  .unsubscribeFromTopic('payment');
              await FirebaseApi()
                  .firebaseMessaging
                  .unsubscribeFromTopic('info');

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
      padding: EdgeInsets.all(16.h),
      children: [
        Text(
          'Profil Saya',
          style: theme.textTheme.titleLarge,
        ),
        SizedBox(height: 20.v),
        const SettingProfile(),
        SizedBox(height: 10.v),
        const Divider(),
        SizedBox(height: 10.v),
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
        SizedBox(height: 20.v),
        ElevatedButton(
          onPressed: _handleLogout,
          child: const Text('Keluar'),
        ),
        SizedBox(height: 20.v),
        Center(
          child: Text(
            'Versi $_appVersion',
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
