import 'package:digister/models/security_model.dart';
import 'package:digister/routes/route_helper.dart';
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
  final void Function(BuildContext, List<Security>?)? onPressed;
}

List<MenuItem> menuItems = [
  MenuItem(
    title: "Iuran",
    imageAsset: ImageAssets.transactionImage,
    onPressed: (BuildContext context, _) => RouteHelper.push(
      context,
      widget: const ConfirmationScreen(),
      transitionType: PageTransitionType.rightToLeft,
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
    onPressed: (BuildContext context, _) => RouteHelper.push(
      context,
      widget: const CCTVScreen(canPop: true),
      transitionType: PageTransitionType.rightToLeft,
    ),
  ),
  MenuItem(
    title: "Asik",
    imageAsset: ImageAssets.asikImage,
    onPressed: (BuildContext context, _) => RouteHelper.push(
      context,
      widget: const Scaffold(
        body: NotFoundScreen(isMainScreen: false),
      ),
      transitionType: PageTransitionType.rightToLeft,
    ),
  ),
  MenuItem(
    title: "Air",
    imageAsset: ImageAssets.waterImage,
    onPressed: (BuildContext context, _) => RouteHelper.push(
      context,
      widget: const Scaffold(
        body: NotFoundScreen(isMainScreen: false),
      ),
      transitionType: PageTransitionType.rightToLeft,
    ),
  ),
  const MenuItem(
    title: "Security",
    imageAsset: ImageAssets.guardImage,
    onPressed: _securitiesModal,
  ),
];

void _securitiesModal(BuildContext context, List<Security>? securities) {
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
                        onPressed: () => _callSecurity(
                          security: item,
                          platform: "tel",
                        ),
                        icon: const Icon(
                          Icons.phone,
                          color: Colors.green,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _callSecurity(
                          security: item,
                          platform: 'wa',
                        ),
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: Image.asset(
                            ImageAssets.whatsappImage,
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
}

void _callSecurity({
  required Security security,
  required String platform,
}) async {
  final phoneNumber = security.phoneNumber.substring(1);

  final Uri url = Uri.parse(
    platform == 'wa' ? "https://wa.me/62$phoneNumber" : "tel:+62$phoneNumber",
  );

  if (!await launchUrl(url)) {
    throw Exception("Could not launch $url");
  }
}
