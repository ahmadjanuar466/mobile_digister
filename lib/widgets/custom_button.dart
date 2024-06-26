import 'package:flutter/material.dart';

enum ButtonShape {
  rounded(StadiumBorder()),
  curved(RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(12),
    ),
  ));

  const ButtonShape(this.value);

  final OutlinedBorder value;
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    required this.text,
    this.backgroundColor,
    this.shape = ButtonShape.rounded,
  });

  final String text;
  final Function()? onPressed;
  final Color? backgroundColor;
  final ButtonShape shape;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: shape.value,
          backgroundColor: backgroundColor,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
