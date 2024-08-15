import 'dart:convert';

import 'package:digister/models/dues_model.dart';
import 'package:digister/models/information_model.dart';
import 'package:digister/models/log_information_model.dart';
import 'package:digister/services/dues.dart';
import 'package:digister/services/housing.dart';
import 'package:digister/services/utils/dio_config.dart';
import 'package:digister/services/utils/exception_handler.dart';
import 'package:dio/dio.dart';
import 'package:localstorage/localstorage.dart';

Future<List<LogInformation>> getLogs() async {
  try {
    final response = await dio.get(
      '/api/log',
      options: Options(headers: {
        'Authorization': 'Bearer ${localStorage.getItem('token')}'
      }),
    );

    final data = response.data;
    final List<LogInformation> notifications = [];
    Dues? dues;
    Information? information;
    for (var item in data['data']) {
      if (item['id_konfirmasi_pembayaran'] != "") {
        dues = await getDuesById(item['id_konfirmasi_pembayaran']);
      }

      if (item['id_informasi'] != "") {
        information = await getInformationById(item['id_informasi']);
      }

      notifications.add(LogInformation.fromJson(item, dues, information));
    }

    return notifications;
  } on DioException catch (_) {
    return [];
  }
}

Future<bool> updateLog(String id) async {
  try {
    await dio.post(
      '/api/log/read',
      options: Options(headers: {
        'Authorization': 'Bearer ${localStorage.getItem('token')}'
      }),
      data: jsonEncode({'id': id}),
    );

    return true;
  } on DioException catch (error) {
    return ExceptionHandler.falseException(error, returnValue: false);
  }
}

Future<bool> deleteLog(String id) async {
  try {
    await dio.get(
      '/api/log/delete/$id',
      options: Options(headers: {
        'Authorization': 'Bearer ${localStorage.getItem('token')}'
      }),
    );

    return true;
  } on DioException catch (error) {
    return ExceptionHandler.falseException(error, returnValue: false);
  }
}
