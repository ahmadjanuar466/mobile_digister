import 'package:digister/utils/global.dart';
import 'package:digister/utils/image_constants.dart';
import 'package:digister/utils/size_util.dart';
import 'package:flutter/material.dart';

class Highlight extends StatelessWidget {
  const Highlight({
    super.key,
    required this.title,
    required this.total,
    required this.onTap,
  });

  final String title;
  final int total;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.v,
      decoration: BoxDecoration(
        color: isDarkMode
            ? theme.colorScheme.primaryContainer
            : theme.colorScheme.onPrimary,
        border: Border.all(
          color: theme.colorScheme.onPrimary.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(20.h),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.secondary.withOpacity(0.1),
            offset: Offset(4.h, 5.v),
            blurRadius: 9,
            spreadRadius: 0,
          )
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -30.h,
            bottom: -10.v,
            child: Image.asset(
              ImageAssets.treasuryImage,
              width: 150.adaptSize,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium,
                ),
                const Spacer(),
                RichText(
                  text: TextSpan(
                    text: total.toString(),
                    style: theme.textTheme.titleLarge!.copyWith(
                      fontSize: 40.fSize,
                    ),
                    children: [
                      TextSpan(
                        text: ' total',
                        style: theme.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(6.h),
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.h),
                    child: Row(
                      children: [
                        Text(
                          'Lihat',
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: theme.colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
