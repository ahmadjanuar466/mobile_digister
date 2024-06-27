import 'dart:convert';

import 'package:digister/models/dues_model.dart';
import 'package:digister/models/log_model.dart';
import 'package:digister/services/dues.dart';
import 'package:digister/utils/dio_config.dart';
import 'package:dio/dio.dart';
import 'package:localstorage/localstorage.dart';

Future<List<LogModel>> getLogs() async {
  try {
    final response = await dio.get(
      '/api/log',
      options: Options(headers: {
        'Authorization': 'Bearer ${localStorage.getItem('token')}'
      }),
    );

    final data = response.data;
    final List<LogModel> notifications = [];
    DuesModel? dues;
    for (var item in data['data']) {
      if (item['id_konfirmasi_pembayaran'].isNotEmpty) {
        dues = await getDuesById(item['id_konfirmasi_pembayaran']);
      }

      notifications.add(LogModel.fromJson(item, dues));
    }

    return notifications;
  } on DioException catch (_) {
    return [];
  }
}

Future<void> updateLog(String id) async {
  try {
    await dio.post(
      '/api/log/read',
      options: Options(headers: {
        'Authorization': 'Bearer ${localStorage.getItem('token')}'
      }),
      data: jsonEncode({'id': id}),
    );
  } on DioException catch (_) {}
}

Future<void> deleteLog(String id) async {
  try {
    await dio.get(
      '/api/log/delete/$id',
      options: Options(headers: {
        'Authorization': 'Bearer ${localStorage.getItem('token')}'
      }),
    );
  } on DioException catch (_) {}
}
