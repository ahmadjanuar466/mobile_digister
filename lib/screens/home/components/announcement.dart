import 'package:digister/models/information_model.dart';
import 'package:digister/utils/global.dart';
import 'package:digister/widgets/empty_data.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Announcement extends StatefulWidget {
  const Announcement({super.key, required this.informations});

  final List<InformationModel> informations;

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.75);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.maxFinite,
          height: 160,
          child: widget.informations.isNotEmpty
              ? PageView.builder(
                  controller: _pageController,
                  itemCount: widget.informations.length,
                  padEnds: false,
                  itemBuilder: (context, index) => Container(
                    width: 250,
                    height: 160,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: MemoryImage(widget.informations[index].image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(20),
                        ),
                      ),
                      child: ListTile(
                        dense: true,
                        title: Text(
                          widget.informations[index].title,
                          style: theme.textTheme.titleSmall!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          widget.informations[index].body,
                          style: theme.textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                )
              : const EmptyData(title: 'Belum ada pengumuman'),
        ),
        const SizedBox(height: 10),
        if (widget.informations.length > 1)
          Align(
            alignment: Alignment.topCenter,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: widget.informations.length,
              effect: WormEffect(
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: theme.colorScheme.primary,
                dotColor: isDarkMode
                    ? theme.colorScheme.onPrimary.withOpacity(0.5)
                    : theme.colorScheme.secondary.withOpacity(0.2),
              ),
            ),
          )
      ],
    );
  }
}
