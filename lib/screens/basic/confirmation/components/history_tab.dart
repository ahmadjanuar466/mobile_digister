import 'package:digister/models/dues_model.dart';
import 'package:digister/screens/basic/confirmation/components/data_exist_view.dart';
import 'package:digister/services/dues.dart';
import 'package:digister/utils/global.dart';
import 'package:digister/widgets/empty_data.dart';
import 'package:flutter/material.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  bool _isLoading = true;
  bool _isDataExist = false;
  final List<Dues> _duesHistory = [];

  @override
  void initState() {
    super.initState();
    _getDuesHistory();
  }

  _getDuesHistory() async {
    final body = {
      "nik": user.nik,
      "pembayaran_thn": DateTime.now().year.toString(),
    };

    _duesHistory.clear();
    final dues = await duesHistory(body);

    if (!mounted) return;

    if (dues.isNotEmpty) {
      setState(() {
        _isDataExist = true;
        _isLoading = false;
        _duesHistory.addAll(dues);
      });
    } else {
      setState(() {
        _isDataExist = false;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (!_isDataExist) {
      return const EmptyData(title: 'Riwayat belum ada');
    }

    return DataExistView(
      listHistory: _duesHistory,
      onRefresh: () => _getDuesHistory(),
    );
  }
}
