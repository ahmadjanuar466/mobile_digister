import 'package:digister/routes/route_helper.dart';
import 'package:digister/screens/basic/confirmation/components/confirmation_tab.dart';
import 'package:digister/screens/basic/confirmation/components/history_tab.dart';
import 'package:digister/utils/global.dart';
import 'package:flutter/material.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({
    super.key,
    this.fromNotification = false,
  });

  final bool fromNotification;

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 1.0,
        title: const Text("Iuran Warga"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Column(
              children: [
                Icon(Icons.article_rounded),
                Text('Konfirmasi'),
              ],
            ),
            Column(
              children: [
                Icon(Icons.history_rounded),
                Text('Riwayat'),
              ],
            ),
          ],
        ),
      ),
      body: PopScope(
        canPop: !widget.fromNotification,
        onPopInvoked: (didPop) {
          if (didPop) return;

          RouteHelper.pop(context);
        },
        child: TabBarView(
          controller: _tabController,
          children: const [
            ConfirmationTab(),
            HistoryTab(),
          ],
        ),
      ),
    );
  }
}
