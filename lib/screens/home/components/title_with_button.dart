import 'package:digister/utils/global.dart';
import 'package:flutter/material.dart';

class TitleWithButton extends StatelessWidget {
  const TitleWithButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: isDarkMode ? theme.colorScheme.secondary : null,
              border: !isDarkMode
                  ? Border.all(color: theme.colorScheme.secondary)
                  : null,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Selengkapnya',
                  style: theme.textTheme.bodySmall,
                ),
                const Icon(Icons.chevron_right_rounded, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
