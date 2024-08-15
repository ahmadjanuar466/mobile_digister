import 'package:digister/screens/basic/404/not_found_screen.dart';
import 'package:digister/utils/global.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    isDarkMode = theme.brightness == Brightness.dark;

    return const Scaffold(
      body: NotFoundScreen(isMainScreen: false),
    );
  }
}
