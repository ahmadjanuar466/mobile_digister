import 'package:digister/models/log_model.dart';
import 'package:digister/routes/route_helper.dart';
import 'package:digister/screens/confirmation/confirmation_screen.dart';
import 'package:digister/screens/loading/loading_screen.dart';
import 'package:digister/services/activity.dart';
import 'package:digister/utils/global.dart';
import 'package:digister/utils/image_constants.dart';
import 'package:digister/widgets/empty_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key, required this.notifications});

  final List<LogModel> notifications;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  void _getUpdatedNotifications() async {
    final notifications = await getLogs();

    if (!mounted) return;
    widget.notifications.clear();
    setState(() {
      widget.notifications.addAll(notifications);
    });
  }

  void _handleTap(LogModel item) {
    updateLog(item.logId);

    if (item.logType == 'Input') {
      RouteHelper.push(
        context,
        widget: const ConfirmationScreen(),
        transitionType: PageTransitionType.rightToLeft,
      ).then((_) => _getUpdatedNotifications());
      return;
    }

    RouteHelper.push(
      context,
      widget: LoadingScreen(dues: item.dues!, isInfo: true),
      transitionType: PageTransitionType.rightToLeft,
    ).then((_) => _getUpdatedNotifications());
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    isDarkMode = theme.brightness == Brightness.dark;
    timeago.setLocaleMessages('idShort', timeago.IdShortMessages());

    return Scaffold(
      body: SafeArea(
        child: widget.notifications.isNotEmpty
            ? ListView(
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Notifikasi',
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...widget.notifications.map(
                    (item) => Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_) async {
                              await deleteLog(item.logId);
                              _getUpdatedNotifications();
                            },
                            backgroundColor: theme.colorScheme.error,
                            foregroundColor: theme.colorScheme.onPrimary,
                            label: 'Hapus',
                          ),
                        ],
                      ),
                      child: ListTile(
                        horizontalTitleGap: 8.0,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 0.0,
                        ),
                        selected: item.isRead == "1",
                        selectedColor: Colors.grey.shade300,
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundColor:
                              theme.colorScheme.primary.withOpacity(0.6),
                          backgroundImage: const ExactAssetImage(
                            ImageAssets.infoNotifImage,
                          ),
                        ),
                        title: Text(
                          item.logTitle,
                          style: theme.textTheme.titleMedium!.copyWith(
                            color: item.isRead == "1" ? Colors.grey : null,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          item.logDesc,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: item.isRead == "1" ? Colors.grey : null,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Text(timeago.format(
                          DateTime.parse(item.logDate),
                          locale: "idShort",
                        )),
                        onTap: () => _handleTap(item),
                      ),
                    ),
                  )
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Notifikasi',
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  const Spacer(),
                  const EmptyData(title: 'Belum ada notifikasi yang masuk'),
                  const Spacer(flex: 2),
                ],
              ),
      ),
    );
  }
}
