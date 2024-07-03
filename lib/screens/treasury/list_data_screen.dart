import 'package:digister/models/dues_model.dart';
import 'package:digister/routes/route_helper.dart';
import 'package:digister/services/treasury.dart';
import 'package:digister/utils/global.dart';
import 'package:digister/utils/image_constants.dart';
import 'package:digister/widgets/empty_data.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:digister/screens/loading/loading_screen.dart';

class ListDataScreen extends StatelessWidget {
  const ListDataScreen({
    super.key,
    required this.listData,
    required this.title,
    required this.listType,
    this.month,
    this.year,
  });

  final List<Dues> listData;
  final String title;
  final String? month;
  final String? year;
  final String listType;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    isDarkMode = theme.brightness == Brightness.dark;

    if (listData.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: Text(title),
        ),
        body: EmptyData(title: '$title masih kosong'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(title),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          children: listData
              .map(
                (item) => ListTile(
                  horizontalTitleGap: 8.0,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                    vertical: 0.0,
                  ),
                  onTap: listType == "unconfirmed"
                      ? () => RouteHelper.push(
                            context,
                            widget: LoadingScreen(dues: item, isInfo: true),
                            transitionType: PageTransitionType.bottomToTop,
                          )
                      : null,
                  leading: const CircleAvatar(
                    radius: 25,
                    backgroundImage: ExactAssetImage(ImageAssets.userImage),
                  ),
                  title: Text(
                    item.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    'Blok ${item.block} Nomor ${item.houseNum}',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  trailing: month != null && year != null
                      ? IconButton(
                          onPressed: () => sendReminder({
                            'bln': month,
                            'thn': year,
                            'id': item.userId,
                          }, item.name),
                          color: theme.colorScheme.primary,
                          icon: const Icon(Icons.broadcast_on_personal),
                        )
                      : listType == 'unconfirmed'
                          ? Text(
                              'Lihat',
                              style: theme.textTheme.bodySmall!.copyWith(
                                color: theme.colorScheme.primary,
                              ),
                            )
                          : null,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
