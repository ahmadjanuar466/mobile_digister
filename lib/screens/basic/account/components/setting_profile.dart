import 'package:digister/routes/route_helper.dart';
import 'package:digister/screens/basic/profile/profile_screen.dart';
import 'package:digister/utils/global.dart';
import 'package:digister/utils/image_constants.dart';
import 'package:digister/utils/size_util.dart';
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
      padding: EdgeInsets.all(10.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.primary,
        ),
        borderRadius: BorderRadius.circular(20.h),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.adaptSize,
                backgroundImage: const ExactAssetImage(
                  ImageAssets.userImage,
                ),
              ),
              SizedBox(width: 8.0.h),
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
          SizedBox(height: 10.h),
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
