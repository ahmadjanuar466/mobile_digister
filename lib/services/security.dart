import 'dart:convert';

import 'package:digister/models/presence_model.dart';
import 'package:digister/services/utils/dio_config.dart';
import 'package:digister/utils/global.dart';
import 'package:dio/dio.dart';
import 'package:localstorage/localstorage.dart';

Future<Presence?> checkPresence() async {
  try {
    final response = await dio.get(
      '/api/absensi',
      options: Options(headers: {
        'Authorization': 'Bearer ${localStorage.getItem('token')}'
      }),
    );

    final data = response.data['data'];

    return Presence.fromJson(data);
  } on DioException catch (_) {
    return Presence();
  }
}

Future<Presence?> doPresence(String type) async {
  try {
    final response = await dio.post(
      '/api/absensi/$type',
      options: Options(headers: {
        'Authorization': 'Bearer ${localStorage.getItem('token')}'
      }),
    );

    final data = response.data;

    return Presence.fromJson(data);
  } on DioException catch (_) {
    return null;
  }
}

Future<List<Presence>> getPresenceHistory() async {
  try {
    final response = await dio.get(
      '/api/absensi/history',
      options: Options(headers: {
        'Authorization': 'Bearer ${localStorage.getItem('token')}'
      }),
      data: jsonEncode({'id_user': user.userId}),
    );

    final data = response.data['data'];
    final List<Presence> presences = [];

    for (var item in data) {
      presences.add(Presence.fromJson(item));
    }

    return presences;
  } on DioException catch (_) {
    return [];
  }
}
