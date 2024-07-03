import 'package:digister/utils/global.dart';
import 'package:digister/utils/lottie_asset.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            LottieAssets.empty,
            repeat: false,
            width: 120,
          ),
          Text(
            title,
            style: theme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
