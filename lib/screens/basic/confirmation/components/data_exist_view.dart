import 'package:digister/models/dues_model.dart';
import 'package:digister/routes/route_helper.dart';
import 'package:digister/screens/basic/loading/loading_screen.dart';
import 'package:digister/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class DataExistView extends StatelessWidget {
  const DataExistView({
    super.key,
    required List<Dues> listHistory,
    required this.onRefresh,
  }) : _listHistory = listHistory;

  final List<Dues> _listHistory;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        children: _listHistory
            .map(
              (item) => ListTile(
                leading: CircleAvatar(
                  radius: 25.adaptSize,
                  backgroundColor: Colors.black12,
                  child: Text(
                    item.paymentMonth!.toString(),
                    style: TextStyle(
                      fontSize: 18.fSize,
                      color: Colors.white,
                    ),
                  ),
                ),
                title: Text(
                  "${item.duesType}, Rp. ${item.duesPrice}",
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  DateFormat("d MMMM yyyy")
                      .format(DateTime.parse(item.paymentDate!)),
                ),
                trailing: Container(
                  padding: EdgeInsets.all(5.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.h),
                    color: item.isValid == 0 ? Colors.amber : Colors.green,
                  ),
                  child: Text(
                    item.isValid == 0 ? "Diproses" : "Divalidasi",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.fSize,
                    ),
                  ),
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
            )
            .toList(),
      ),
    );
  }
}
