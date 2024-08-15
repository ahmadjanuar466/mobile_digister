import 'package:digister/screens/basic/404/not_found_screen.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const NotFoundScreen(isMainScreen: true);
  }
}
