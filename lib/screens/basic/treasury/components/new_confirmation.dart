import 'package:digister/models/confirm_dues_model.dart';
import 'package:digister/routes/route_helper.dart';
import 'package:digister/screens/basic/loading/loading_screen.dart';
import 'package:digister/utils/global.dart';
import 'package:digister/utils/image_constants.dart';
import 'package:digister/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewConfirmation extends StatelessWidget {
  const NewConfirmation({
    super.key,
    required this.unConfirmedCitizens,
    required this.onRefresh,
  });

  final ConfirmDues? unConfirmedCitizens;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: isDarkMode
          ? theme.colorScheme.primaryContainer
          : theme.colorScheme.onPrimary,
      onRefresh: onRefresh,
      child: ListView(
        children:
            unConfirmedCitizens != null && unConfirmedCitizens!.dues.isNotEmpty
                ? unConfirmedCitizens!.dues
                    .map(
                      (item) => Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: theme.colorScheme.primary,
                          ),
                          borderRadius: BorderRadius.circular(16.h),
                        ),
                        child: ListTile(
                          horizontalTitleGap: 8.0.h,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 5.0.h,
                            vertical: 0.0,
                          ),
                          leading: CircleAvatar(
                            radius: 25.adaptSize,
                            backgroundImage: const ExactAssetImage(
                              ImageAssets.userImage,
                            ),
                          ),
                          title: Text(
                            item.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            item.duesType!,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Text(
                            timeago.format(
                              DateTime.parse(item.paymentDate!),
                              locale: "idShort",
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () => RouteHelper.push(
                            context,
                            widget: LoadingScreen(
                              dues: item,
                              isInfo: true,
                            ),
                            transitionType: PageTransitionType.bottomToTop,
                          ),
                        ),
                      ),
                    )
                    .toList()
                : [],
      ),
    );
  }
}
