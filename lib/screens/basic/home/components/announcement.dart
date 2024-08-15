import 'package:digister/models/information_model.dart';
import 'package:digister/routes/route_helper.dart';
import 'package:digister/screens/basic/announcement/announcement_detail_screen.dart';
import 'package:digister/utils/global.dart';
import 'package:digister/utils/size_util.dart';
import 'package:digister/widgets/empty_data.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Announcement extends StatefulWidget {
  const Announcement({
    super.key,
    required this.informations,
  });

  final List<Information> informations;

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.90);
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
          height: 180.v,
          child: widget.informations.isNotEmpty
              ? PageView.builder(
                  controller: _pageController,
                  itemCount: widget.informations.length,
                  padEnds: false,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => RouteHelper.push(
                      context,
                      widget: AnnouncementDetailScreen(
                        information: widget.informations[index],
                      ),
                      transitionType: PageTransitionType.rightToLeft,
                    ),
                    child: Container(
                      width: 250.h,
                      height: 180.v,
                      margin: EdgeInsets.symmetric(horizontal: 5.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.h),
                        image: DecorationImage(
                          image: MemoryImage(widget.informations[index].image),
                          fit: BoxFit.cover,
                        ),
                      ),
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(20.h),
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
                  ),
                )
              : const EmptyData(title: 'Belum ada pengumuman'),
        ),
        SizedBox(height: 10.v),
        if (widget.informations.length > 1)
          Align(
            alignment: Alignment.topCenter,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: widget.informations.length,
              effect: WormEffect(
                dotHeight: 10.v,
                dotWidth: 10.h,
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
