import 'package:digister/screens/404/not_found_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: NotFoundScreen(isMainScreen: false),
    );
  }
}
