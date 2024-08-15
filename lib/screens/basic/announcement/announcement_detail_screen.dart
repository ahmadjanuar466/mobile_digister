import 'package:digister/models/information_model.dart';
import 'package:digister/routes/route_helper.dart';
import 'package:digister/utils/global.dart';
import 'package:digister/utils/size_util.dart';
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
          padding: EdgeInsets.all(16.h),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                children: [
                  SizedBox(height: 70.v),
                  Expanded(
                    child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.all(16.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(20.h),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 130.v),
                          Text(
                            information.title,
                            style: theme.textTheme.titleLarge!.copyWith(
                              fontSize: 26.fSize,
                            ),
                            overflow: TextOverflow.clip,
                          ),
                          SizedBox(height: 5.v),
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
                              Icon(
                                Icons.circle,
                                color: Colors.grey,
                                size: 8.adaptSize,
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
                          SizedBox(height: 20.v),
                          Text(
                            'Isi pengumuman',
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 10.v),
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
                padding: EdgeInsets.symmetric(horizontal: 25.h),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.h),
                  child: Image.memory(
                    information.image,
                    height: 200.adaptSize,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
