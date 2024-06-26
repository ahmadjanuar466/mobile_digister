import 'package:digister/utils/global.dart';
import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        margin: const EdgeInsets.only(right: 10, bottom: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.colorScheme.primary,
        ),
        child: Icon(
          icon,
          size: 35,
          color: Colors.white,
        ),
      ),
    );
  }
}
