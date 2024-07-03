import 'package:digister/models/information_model.dart';
import 'package:digister/routes/route_helper.dart';
import 'package:digister/screens/announcement/announcement_detail_screen.dart';
import 'package:digister/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:page_transition/page_transition.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key, required this.informations});

  final List<Information> informations;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 1.0,
        title: const Text('Daftar pengumuman'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemCount: informations.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => RouteHelper.push(
                context,
                widget:
                    AnnouncementDetailScreen(information: informations[index]),
                transitionType: PageTransitionType.rightToLeft,
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.memory(informations[index].image),
                  ),
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          informations[index].title,
                          style: theme.textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          informations[index].body,
                          style: theme.textTheme.labelSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
