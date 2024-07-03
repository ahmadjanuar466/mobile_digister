import 'package:digister/routes/route_helper.dart';
import 'package:digister/screens/profile/profile_screen.dart';
import 'package:digister/utils/global.dart';
import 'package:digister/utils/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SettingProfile extends StatelessWidget {
  const SettingProfile({super.key});

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.primary,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundImage: ExactAssetImage(
                  ImageAssets.userImage,
                ),
              ),
              const SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.nama,
                    style: theme.textTheme.titleMedium,
                  ),
                  Text(
                    user.email,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: isDarkMode
                          ? theme.colorScheme.onPrimary.withOpacity(0.65)
                          : theme.colorScheme.secondary.withOpacity(0.5),
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () => RouteHelper.push(
                context,
                widget: const ProfileScreen(),
                transitionType: PageTransitionType.rightToLeft,
              ),
              child: Text(
                'Ubah profil',
                style: theme.textTheme.titleSmall!.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
