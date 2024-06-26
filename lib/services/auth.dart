import 'dart:convert';

import 'package:digister/models/user_level_model.dart';
import 'package:digister/models/user_model.dart';
import 'package:digister/utils/dio_config.dart';
import 'package:digister/utils/global.dart';
import 'package:digister/utils/jwt_decoder.dart';
import 'package:digister/widgets/notification.dart';
import 'package:dio/dio.dart';
import 'package:localstorage/localstorage.dart';
import 'package:toastification/toastification.dart';

Future<bool> doRegister(Map<String, dynamic> body) async {
  try {
    await dio.post(
      '/api/registrasi/reg',
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

Future<bool> doLogin(Map<String, dynamic> body) async {
  try {
    final response = await dio.post(
      '/api/registrasi/login',
      data: jsonEncode(body),
    );

    final token = response.data['token'];

    final decodedToken = JwtDecoder.decodeJwt(token);
    final payload = decodedToken['payload'];

    localStorage.setItem('token', token);

    user = UserModel.fromJson(payload['data']);
    userLevel = UserLevelModel.fromJson(payload['lvl']);

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

Future<bool> checkUserNIK(Map<String, String> body) async {
  try {
    await dio.post(
      '/api/warga/checknik',
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

Future<bool> resetPassword(Map<String, String> body) async {
  try {
    await dio.post(
      '/api/registrasi/changepassword',
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

Future<void> saveToken(String token) async {
  try {
    await dio.post(
      '/api/warga/token_user',
      options: Options(headers: {
        'Authorization': 'Bearer ${localStorage.getItem('token')}'
      }),
      data: jsonEncode({
        'id': user.userId,
        'token': token,
      }),
    );
  } on DioException catch (_) {}
}
