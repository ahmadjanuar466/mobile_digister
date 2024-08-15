import 'package:digister/utils/global.dart';
import 'package:digister/utils/size_util.dart';
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
        width: 60.h,
        height: 60.v,
        margin: EdgeInsets.only(right: 10.h, bottom: 10.v),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.colorScheme.primary,
        ),
        child: Icon(
          icon,
          size: 35.adaptSize,
          color: Colors.white,
        ),
      ),
    );
  }
}
