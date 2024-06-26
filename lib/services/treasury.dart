import 'dart:convert';
import 'package:digister/models/confirm_dues_model.dart';
import 'package:digister/models/dues_model.dart';
import 'package:digister/utils/dio_config.dart';
import 'package:digister/widgets/notification.dart';
import 'package:dio/dio.dart';
import 'package:localstorage/localstorage.dart';
import 'package:toastification/toastification.dart';

Future<bool> createPosting(Map<String, String> body) async {
  try {
    await dio.post(
      '/api/bendahara/postingiuran',
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

Future<ConfirmDuesModel?> getCitizens(
  String uri,
  Map<String, String> body,
) async {
  try {
    final response = await dio.post(
      uri,
      options: Options(headers: {
        'Authorization': 'Bearer ${localStorage.getItem('token')}'
      }),
      data: jsonEncode(body),
    );

    final data = response.data;
    final List<DuesModel> dues = [];
    for (var item in data['data']['data']) {
      dues.add(DuesModel.fromJson(item));
    }

    return ConfirmDuesModel(
      total: data['data']['total'],
      dues: dues,
    );
  } on DioException catch (error) {
    final data = error.response?.data;

    if (data != null) {
      NotificationWidget.show(
        title: 'Error!',
        description: data['msg'],
        type: ToastificationType.error,
      );
    }
  }
  return null;
}

Future<void> sendReminder(Map<String, dynamic> body, String name) async {
  try {
    await dio.post(
      '/api/bendahara/notifpersonal',
      options: Options(headers: {
        'Authorization': 'Bearer ${localStorage.getItem('token')}'
      }),
      data: jsonEncode(body),
    );

    NotificationWidget.show(
      title: 'Success!',
      description: 'Bpk/Ibu $name sudah diingatkan',
      type: ToastificationType.error,
    );
  } on DioException catch (error) {
    final data = error.response?.data;

    if (data != null) {
      NotificationWidget.show(
        title: 'Error!',
        description: data['msg'],
        type: ToastificationType.error,
      );
    }
  }
}
