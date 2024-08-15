import 'dart:convert';

import 'package:digister/models/dues_model.dart';
import 'package:digister/models/dues_type_model.dart';
import 'package:digister/services/utils/dio_config.dart';
import 'package:digister/services/utils/exception_handler.dart';
import 'package:dio/dio.dart';
import 'package:localstorage/localstorage.dart';

Future<List<DuesType>> getDues() async {
  try {
    final response = await dio.get(
      '/api/konfirmasi/jenisiuran',
      options: Options(headers: {
        'Authorization': 'Bearer ${localStorage.getItem('token')}'
      }),
    );

    final data = response.data;
    final List<DuesType> duesList = [];
    for (var item in data['data']) {
      duesList.add(DuesType.fromJson(item));
    }

    return duesList;
  } on DioException catch (error) {
    return ExceptionHandler.falseException(error, returnValue: <DuesType>[]);
  }
}

Future<bool> confirmDues(Map<String, dynamic> body) async {
  try {
    await dio.post(
      '/api/konfirmasi/add',
      options: Options(headers: {
        'Authorization': 'Bearer ${localStorage.getItem('token')}'
      }),
      data: jsonEncode(body),
    );

    return true;
  } on DioException catch (error) {
    return ExceptionHandler.falseException(error, returnValue: false);
  }
}

Future<bool> validateDues(Map<String, dynamic> body) async {
  try {
    await dio.post(
      '/api/konfirmasi/validasipembayaran',
      options: Options(headers: {
        'Authorization': 'Bearer ${localStorage.getItem('token')}'
      }),
      data: jsonEncode(body),
    );

    return true;
  } on DioException catch (error) {
    return ExceptionHandler.falseException(error, returnValue: false);
  }
}

Future<List<Dues>> duesHistory(Map<String, String> body) async {
  try {
    final response = await dio.post(
      '/api/konfirmasi/listwarga',
      options: Options(headers: {
        'Authorization': 'Bearer ${localStorage.getItem('token')}'
      }),
      data: jsonEncode(body),
    );

    final data = response.data;
    final List<Dues> dues = [];
    for (var item in data['data']) {
      dues.add(Dues.fromJson(item));
    }

    return dues;
  } on DioException catch (error) {
    return ExceptionHandler.falseException(error, returnValue: <Dues>[]);
  }
}

Future<Dues?> getDuesById(String id) async {
  try {
    final response = await dio.get(
      "/api/konfirmasi/$id",
      options: Options(headers: {
        'Authorization': 'Bearer ${localStorage.getItem('token')}'
      }),
    );

    final data = response.data;

    return Dues.fromJson(data['data']);
  } on DioException catch (error) {
    return ExceptionHandler.falseException(error, returnValue: null);
  }
}
