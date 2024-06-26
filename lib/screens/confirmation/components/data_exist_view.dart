import 'package:digister/models/dues_model.dart';
import 'package:digister/routes/route_helper.dart';
import 'package:digister/screens/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class DataExistView extends StatelessWidget {
  const DataExistView({
    super.key,
    required List<DuesModel> listHistory,
    required this.onRefresh,
  }) : _listHistory = listHistory;

  final List<DuesModel> _listHistory;
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
                  radius: 25,
                  backgroundColor: Colors.black12,
                  child: Text(
                    item.paymentMonth!.toString(),
                    style: const TextStyle(
                      fontSize: 18,
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
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: item.isValid == 0 ? Colors.amber : Colors.green,
                  ),
                  child: Text(
                    item.isValid == 0 ? "Diproses" : "Divalidasi",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
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
