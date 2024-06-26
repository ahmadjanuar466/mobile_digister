import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioConfig {
  static final optionAPI = BaseOptions(
    baseUrl: dotenv.env['BASE_URL'] as String,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
    headers: {'Content-Type': 'application/json'},
  );
}

final dio = Dio(DioConfig.optionAPI);
