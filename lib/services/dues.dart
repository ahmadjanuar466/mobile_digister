import 'dart:convert';

import 'package:digister/models/dues_model.dart';
import 'package:digister/models/dues_type_model.dart';
import 'package:digister/utils/dio_config.dart';
import 'package:digister/widgets/notification.dart';
import 'package:dio/dio.dart';
import 'package:localstorage/localstorage.dart';
import 'package:toastification/toastification.dart';

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
  } on DioException catch (_) {
    return [];
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
    final data = error.response?.data;

    if (data != null) {
      NotificationWidget.show(
        title: 'Error!',
        description: data['msg'],
        type: ToastificationType.error,
      );
    }

    return false;
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
    final data = error.response?.data;

    if (data != null) {
      NotificationWidget.show(
        title: 'Error!',
        description: data['msg'],
        type: ToastificationType.error,
      );
    }

    return false;
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
  } on DioException catch (_) {
    return [];
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
    final data = error.response?.data;

    if (data != null) {
      NotificationWidget.show(
        title: 'Error!',
        description: data['msg'],
        type: ToastificationType.error,
      );
    }

    return null;
  }
}
