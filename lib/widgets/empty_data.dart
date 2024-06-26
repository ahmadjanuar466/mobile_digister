import 'package:digister/utils/global.dart';
import 'package:flutter/material.dart';

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
          const Icon(Icons.article, size: 100),
          Text(
            title,
            style: theme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
