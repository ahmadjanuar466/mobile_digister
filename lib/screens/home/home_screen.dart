import 'package:digister/models/information_model.dart';
import 'package:digister/models/log_information_model.dart';
import 'package:digister/models/security_model.dart';
import 'package:digister/models/weather_model.dart';
import 'package:digister/routes/route_helper.dart';
import 'package:digister/screens/announcement/announcement_screen.dart';
import 'package:digister/screens/home/components/announcement.dart';
// import 'package:digister/screens/home/components/available_service.dart';
import 'package:digister/screens/home/components/card_header.dart';
import 'package:digister/screens/home/components/header.dart';
import 'package:digister/screens/home/components/title_with_button.dart';
import 'package:digister/services/activity.dart';
import 'package:digister/services/housing.dart';
import 'package:digister/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:digister/models/home_menu_model.dart';
import 'package:digister/utils/global.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Security> _securities = [];
  final List<LogInformation> _notifications = [];
  final List<Information> _informations = [];
  final List<Information> _limitedInformations = [];
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _getWeather();
    _getNotifications();
    _getSecurities();
    _getInformations();
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

  Future<void> _getInformations() async {
    final informations = await getInformations();

    if (!mounted) return;

    _informations.clear();
    _limitedInformations.clear();
    setState(() {
      _informations.addAll(informations);

      if (informations.length > 6) {
        for (var i = 0; i < 6; i++) {
          _limitedInformations.add(informations[i]);
        }
      }
    });
  }

  Future<void> _getWeather() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final weather = await getWeahter(
      "${position.latitude},${position.longitude}",
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (!mounted) return;

    setState(() {
      _weather = weather;
      _weather?.cityName =
          placemarks[0].subAdministrativeArea?.replaceAll('Kota ', '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _getWeather();
        _getNotifications();
        _getSecurities();
        _getInformations();
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CardHeader(weather: _weather),
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
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10),
          //   child: TitleWithButton(
          //     onTap: () {},
          //     title: 'Layanan tersedia',
          //   ),
          // ),
          // const SizedBox(height: 10),
          // const AvailableService(),
          // const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TitleWithButton(
              onTap: () => RouteHelper.push(
                context,
                widget: AnnouncementScreen(informations: _informations),
                transitionType: PageTransitionType.rightToLeft,
              ),
              title: 'Pengumuman',
            ),
          ),
          const SizedBox(height: 10),
          Announcement(
            informations: _limitedInformations.isNotEmpty
                ? _limitedInformations
                : _informations,
          ),
        ],
      ),
    );
  }
}
