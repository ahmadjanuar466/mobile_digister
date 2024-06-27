import 'package:digister/models/log_model.dart';
import 'package:digister/routes/route_helper.dart';
import 'package:digister/screens/notification/notification_screen.dart';
import 'package:digister/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.notifications,
  });

  final List<LogModel> notifications;

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
          onPressed: () => RouteHelper.push(
            context,
            widget: NotificationScreen(notifications: notifications),
            transitionType: PageTransitionType.rightToLeft,
          ),
          icon: Badge(
            alignment: Alignment.topLeft,
            backgroundColor: theme.colorScheme.primary,
            textColor: theme.colorScheme.onPrimary,
            label: Text(notifications.length.toString()),
            isLabelVisible: notifications.isNotEmpty,
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
