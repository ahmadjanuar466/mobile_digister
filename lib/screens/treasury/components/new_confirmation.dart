import 'package:digister/models/confirm_dues_model.dart';
import 'package:digister/routes/route_helper.dart';
import 'package:digister/screens/loading/loading_screen.dart';
import 'package:digister/utils/global.dart';
import 'package:digister/utils/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewConfirmation extends StatelessWidget {
  const NewConfirmation({
    super.key,
    required this.unConfirmedCitizens,
    required this.onRefresh,
  });

  final ConfirmDuesModel? unConfirmedCitizens;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('id', timeago.IdMessages());

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
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          horizontalTitleGap: 8.0,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 5.0,
                            vertical: 0.0,
                          ),
                          leading: const CircleAvatar(
                            radius: 25,
                            backgroundImage: ExactAssetImage(
                              ImageAssets.userImage,
                            ),
                          ),
                          title: Text(
                            item.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(item.duesType!),
                          trailing: Text(
                            timeago.format(
                              DateTime.parse(item.paymentDate!),
                              locale: "id",
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
