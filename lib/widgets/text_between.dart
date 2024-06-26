import 'package:flutter/material.dart';

class TextBetween extends StatelessWidget {
  final String text1;
  final String text2;
  final FontWeight? fontWeight;
  final double? size;
  final EdgeInsetsGeometry? padding;
  const TextBetween({
    super.key,
    required this.text1,
    required this.text2,
    this.size,
    this.fontWeight,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text1,
              style: TextStyle(
                fontWeight: fontWeight,
                // color: Colors.white,
                fontSize: size,
              ),
            ),
          ),
          Flexible(
            child: Text(
              text2,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: size,
                fontWeight: fontWeight,
                // color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
