import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../loading/loading_screen.dart';

class TableContentContainer extends StatelessWidget {
  const TableContentContainer({
    super.key,
    required this.unconfirmedList,
    required this.getUnPaidData,
    required this.getPaidData,
    required this.getUnconfirmedData,
    required this.getConfirmedData,
  });

  final Map<String, dynamic> unconfirmedList;
  final void Function() getUnPaidData;
  final void Function() getPaidData;
  final void Function() getUnconfirmedData;
  final void Function() getConfirmedData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
      ),
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: TableContent(
        unconfirmedList: unconfirmedList,
        getConfirmedData: getConfirmedData,
        getPaidData: getPaidData,
        getUnPaidData: getUnPaidData,
        getUnconfirmedData: getUnconfirmedData,
      ),
    );
  }
}

class TableContent extends StatelessWidget {
  const TableContent({
    super.key,
    required this.unconfirmedList,
    required this.getUnPaidData,
    required this.getPaidData,
    required this.getUnconfirmedData,
    required this.getConfirmedData,
  });

  final Map<String, dynamic> unconfirmedList;
  final void Function() getUnPaidData;
  final void Function() getPaidData;
  final void Function() getUnconfirmedData;
  final void Function() getConfirmedData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Baru - baru Ini",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        if (unconfirmedList['total'] != 0)
          ...unconfirmedList['data']
              .map(
                (item) => ListTile(
                  horizontalTitleGap: 10.0,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.account_circle,
                      size: 40,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  title: Text(
                    item['nama'],
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    item['nama_jenis_iuran'],
                  ),
                  trailing: Text(
                    timeago.format(
                      DateTime.parse(item['tgl_pembayaran']),
                      locale: "id",
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () => Navigator.push(
                    context,
                    PageTransition(
                      child: LoadingScreen(
                        dues: item,
                        isInfo: true,
                      ),
                      type: PageTransitionType.bottomToTop,
                    ),
                  ).then((value) {
                    getUnPaidData();
                    getPaidData();
                    getUnconfirmedData();
                    getConfirmedData();
                  }),
                ),
              )
              .toList()
      ],
    );
  }
}
