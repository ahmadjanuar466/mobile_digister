import 'package:digister/models/information_model.dart';
import 'package:digister/routes/route_helper.dart';
import 'package:digister/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class AnnouncementDetailScreen extends StatelessWidget {
  const AnnouncementDetailScreen({
    super.key,
    required this.information,
    this.fromNotification = false,
  });

  final Information information;
  final bool fromNotification;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 1.0,
        title: Text(
          information.title,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: PopScope(
        canPop: fromNotification,
        onPopInvoked: (didPop) {
          if (didPop) return;

          RouteHelper.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 80),
                  Expanded(
                    child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 120),
                          Text(
                            information.title,
                            style: theme.textTheme.titleLarge!.copyWith(
                              fontSize: 28,
                            ),
                            overflow: TextOverflow.clip,
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "Diposting oleh",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Row(
                            children: [
                              Text(
                                "${information.postinger} ",
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const Icon(
                                Icons.circle,
                                color: Colors.grey,
                                size: 8,
                              ),
                              Text(
                                " ${timeago.format(
                                  DateTime.parse(information.postDate),
                                  locale: "id",
                                )}",
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Isi pengumuman',
                            style: theme.textTheme.titleLarge,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            information.body,
                            textAlign: TextAlign.justify,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.memory(information.image),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
