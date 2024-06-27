import 'package:digister/models/log_model.dart';
import 'package:digister/models/security_model.dart';
import 'package:digister/screens/home/components/card_header.dart';
import 'package:digister/screens/home/components/header.dart';
import 'package:digister/services/activity.dart';
import 'package:digister/services/housing.dart';
import 'package:digister/utils/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:digister/models/home_menu_model.dart';
import 'package:digister/utils/global.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  final List<SecurityModel> _securities = [];
  final List<LogModel> _notifications = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.75);
    _getNotifications();
    _getSecurities();
  }

  Future<void> _getNotifications() async {
    final notifications = await getLogs();

    if (!mounted) return;

    _notifications.clear();
    setState(() {
      _notifications.addAll(notifications);
    });
  }

  Future<void> _getSecurities() async {
    final securities = await getSecurity();

    if (!mounted) return;

    _securities.clear();
    setState(() {
      _securities.addAll(securities);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _getNotifications();
        _getSecurities();
      },
      backgroundColor: isDarkMode
          ? theme.colorScheme.secondary
          : theme.colorScheme.onPrimary,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Header(notifications: _notifications),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CardHeader(),
          ),
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('Menu'),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: menuItems
                  .map(
                    (item) => InkWell(
                      onTap: () => item.onPressed!(context, _securities),
                      child: Column(
                        children: [
                          Image.asset(item.imageAsset, width: 45),
                          Text(
                            item.title,
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TitleWithButton(
              onTap: () {},
              title: 'Layanan tersedia',
            ),
          ),
          const SizedBox(height: 10),
          const AvailableService(),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TitleWithButton(
              onTap: () {},
              title: 'Pengumuman',
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.maxFinite,
            height: 160,
            child: PageView.builder(
              controller: _pageController,
              itemCount: 6,
              padEnds: false,
              itemBuilder: (context, index) => Container(
                width: 250,
                height: 160,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: ExactAssetImage(ImageAssets.announcementImage),
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
                      "Lorem ipsum",
                      style: theme.textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.topCenter,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 6,
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
      ),
    );
  }
}

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

class AvailableService extends StatelessWidget {
  const AvailableService({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 130,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: 130,
            height: 130,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: ExactAssetImage(ImageAssets.gallonImage),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Galon', style: TextStyle(color: Colors.white)),
                  Icon(Icons.chevron_right_rounded, color: Colors.white),
                ],
              ),
            ),
          ),
          Container(
            width: 130,
            height: 130,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: ExactAssetImage(ImageAssets.laundryImage),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Laundry', style: TextStyle(color: Colors.white)),
                  Icon(Icons.chevron_right_rounded, color: Colors.white),
                ],
              ),
            ),
          ),
          Container(
            width: 130,
            height: 130,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: ExactAssetImage(ImageAssets.workshopImage),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Bengkel', style: TextStyle(color: Colors.white)),
                  Icon(Icons.chevron_right_rounded, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
