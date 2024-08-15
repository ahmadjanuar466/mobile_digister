import 'dart:convert';

import 'package:digister/models/user_level_model.dart';
import 'package:digister/models/user_model.dart';
import 'package:digister/services/utils/dio_config.dart';
import 'package:digister/services/utils/exception_handler.dart';
import 'package:digister/utils/global.dart';
import 'package:digister/utils/jwt_decoder.dart';
import 'package:dio/dio.dart';
import 'package:localstorage/localstorage.dart';

Future<bool> doRegister(Map<String, dynamic> body) async {
  try {
    await dio.post(
      '/api/registrasi/reg',
      data: jsonEncode(body),
    );

    return true;
  } on DioException catch (error) {
    return ExceptionHandler.falseException(error, returnValue: false);
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

    user = User.fromJson(payload['data']);
    userLevel = UserLevel.fromJson(payload['lvl']);

    return true;
  } on DioException catch (error) {
    return ExceptionHandler.falseException(error, returnValue: false);
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
    return ExceptionHandler.falseException(error, returnValue: false);
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
    return ExceptionHandler.falseException(error, returnValue: false);
  }
}

Future<bool> saveToken(String token) async {
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

    return true;
  } on DioException catch (error) {
    return ExceptionHandler.falseException(error, returnValue: false);
  }
}
