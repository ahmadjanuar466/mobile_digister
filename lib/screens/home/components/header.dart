import 'package:digister/utils/global.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hi,'),
            Text(user.nama),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: Badge(
            alignment: Alignment.topLeft,
            backgroundColor: theme.colorScheme.primary,
            textColor: theme.colorScheme.onPrimary,
            label: const Text('5'),
            child: const Icon(
              Icons.notifications_rounded,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}
