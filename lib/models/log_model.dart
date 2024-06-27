import 'package:digister/models/dues_model.dart';

class LogModel {
  final String logId;
  final String userId;
  final String name;
  final String logTitle;
  final String logDesc;
  final String logType;
  final String logDate;
  final String isRead;
  final DuesModel? dues;

  const LogModel({
    required this.logId,
    required this.userId,
    required this.name,
    required this.logTitle,
    required this.logDesc,
    required this.logType,
    required this.logDate,
    required this.isRead,
    this.dues,
  });

  factory LogModel.fromJson(Map<String, dynamic> data, DuesModel? dues) {
    return LogModel(
      logId: data['id_log'],
      userId: data['id_user'],
      name: data['name'],
      logTitle: data['title_log'],
      logDesc: data['log'],
      logType: data['tipe'],
      logDate: data['log_date'],
      isRead: data['is_read'],
      dues: dues,
    );
  }
}
