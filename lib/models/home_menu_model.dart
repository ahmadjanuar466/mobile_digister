import 'package:digister/models/security_model.dart';
import 'package:digister/utils/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:digister/screens/404/not_found_screen.dart';
import 'package:digister/screens/cctv/cctv_screen.dart';
import 'package:digister/screens/confirmation/confirmation_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/global.dart';

class MenuItem {
  const MenuItem({
    required this.title,
    required this.imageAsset,
    required this.onPressed,
  });

  final String title;
  final String imageAsset;
  final void Function(BuildContext, List<SecurityModel>?)? onPressed;
}

List<MenuItem> menuItems = [
  MenuItem(
    title: "Iuran",
    imageAsset: ImageAssets.transactionImage,
    onPressed: (BuildContext context, _) => Navigator.push(
      context,
      PageTransition(
        child: const ConfirmationScreen(),
        type: PageTransitionType.rightToLeft,
      ),
    ),
  ),
  MenuItem(
    title: "Info",
    imageAsset: ImageAssets.infoImage,
    onPressed: (BuildContext context, _) async {
      final Uri url = Uri.parse("http://instagram.com/info.asvil");

      if (!await launchUrl(url)) {
        throw Exception("Could not launch $url");
      }
    },
  ),
  MenuItem(
    title: "CCTV",
    imageAsset: ImageAssets.cctvImage,
    onPressed: (BuildContext context, _) => Navigator.push(
      context,
      PageTransition(
        child: const CCTVScreen(canPop: true),
        type: PageTransitionType.rightToLeft,
      ),
    ),
  ),
  MenuItem(
    title: "Asik",
    imageAsset: ImageAssets.asikImage,
    onPressed: (BuildContext context, _) => Navigator.push(
      context,
      PageTransition(
        child: const Scaffold(
          body: NotFoundScreen(isMainScreen: false),
        ),
        type: PageTransitionType.rightToLeft,
      ),
    ),
  ),
  MenuItem(
    title: "Air",
    imageAsset: ImageAssets.waterImage,
    onPressed: (BuildContext context, _) => Navigator.push(
      context,
      PageTransition(
        child: const Scaffold(
          body: NotFoundScreen(isMainScreen: false),
        ),
        type: PageTransitionType.rightToLeft,
      ),
    ),
  ),
  MenuItem(
    title: "Security",
    imageAsset: ImageAssets.guardImage,
    onPressed: (BuildContext context, securities) {
      showModalBottomSheet(
        context: context,
        showDragHandle: true,
        backgroundColor: theme.colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        builder: (context) => SizedBox(
          height: 300,
          width: double.maxFinite,
          child: Column(
            children: securities!
                .where((element) => element.isActive == "1")
                .map(
                  (item) => ListTile(
                    leading: const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(ImageAssets.guardImage),
                    ),
                    title: Text(
                      item.name,
                      style: const TextStyle(fontSize: 14),
                    ),
                    subtitle: Text(
                      item.phoneNumber,
                      style: const TextStyle(fontSize: 14),
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () async {
                              var phoneNumber = item.phoneNumber.substring(1);

                              final Uri url = Uri.parse(
                                "tel:+62$phoneNumber",
                              );

                              if (!await launchUrl(url)) {
                                throw Exception("Could not launch $url");
                              }
                            },
                            icon: const Icon(
                              Icons.phone,
                              color: Colors.green,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              var phoneNumber = item.phoneNumber.substring(1);

                              final Uri url = Uri.parse(
                                "https://wa.me/62$phoneNumber",
                              );

                              if (!await launchUrl(url)) {
                                throw Exception("Could not launch $url");
                              }
                            },
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: Image.asset(
                                "assets/images/whatsapp.png",
                                width: 1000.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      );
    },
  ),
];
