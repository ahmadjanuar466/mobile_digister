import 'package:digister/models/weather_model.dart';
import 'package:digister/utils/dio_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<Weather?> getWeahter(String latlong) async {
  try {
    final response = await dioForecast.get(
      '/v1/forecast.json?key=${dotenv.env['FORECAST_API_KEY']}&q=$latlong&lang=id',
    );

    final data = response.data;

    return Weather.fromJson(data);
  } on DioException catch (_) {
    return null;
  }
}
