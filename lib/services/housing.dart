import 'dart:convert';

import 'package:digister/models/block_model.dart';
import 'package:digister/models/cctv_model.dart';
import 'package:digister/models/housing_model.dart';
import 'package:digister/models/information_model.dart';
import 'package:digister/models/security_model.dart';
import 'package:digister/utils/dio_config.dart';
import 'package:digister/widgets/notification.dart';
import 'package:dio/dio.dart';
import 'package:localstorage/localstorage.dart';
import 'package:toastification/toastification.dart';

Future<List<Block>> getBlocks() async {
  try {
    final response = await dio.get(
      '/api/registrasi/blok',
      options: Options(headers: {
        'Authorization': 'Bearer ${localStorage.getItem('token')}'
      }),
    );

    final data = response.data;
    final List<Block> blocks = [];
    for (var item in data['data']) {
      blocks.add(Block.fromJson(item));
    }

    return blocks;
  } on DioException catch (_) {
    return [];
  }
}

Future<List<Housing>> getHousings() async {
  try {
    final response = await dio.get(
      '/api/registrasi/perumahan',
      options: Options(headers: {
        'Authorization': 'Bearer ${localStorage.getItem('token')}'
      }),
    );

    final data = response.data;
    final List<Housing> housings = [];
    for (var item in data['data']) {
      housings.add(Housing.fromJson(item));
    }

    return housings;
  } on DioException catch (_) {
    return [];
  }
}

Future<List<Security>> getSecurity() async {
  try {
    final response = await dio.get(
      '/api/warga/security',
      options: Options(headers: {
        'Authorization': 'Bearer ${localStorage.getItem('token')}'
      }),
    );

    final data = response.data;
    final List<Security> securities = [];
    for (var item in data['data']) {
      securities.add(Security.fromJson(item));
    }

    return securities;
  } on DioException catch (_) {
    return [];
  }
}

Future<List<CCTV>> getCCTV(String block) async {
  try {
    final response = await dio.post(
      '/api/warga/cctv',
      options: Options(headers: {
        'Authorization': 'Bearer ${localStorage.getItem('token')}'
      }),
      data: jsonEncode({'blok': block}),
    );

    final data = response.data;
    final List<CCTV> cctvs = [];
    for (var item in data['data']) {
      cctvs.add(CCTV.fromJson(item));
    }

    return cctvs;
  } on DioException catch (error) {
    final data = error.response?.data;

    if (data != null) {
      NotificationWidget.show(
        title: 'Error!',
        description: data['msg'],
        type: ToastificationType.error,
      );
    }

    return [];
  }
}

Future<List<Information>> getInformations() async {
  try {
    final response = await dio.get(
      '/api/informasi',
      options: Options(headers: {
        'Authorization': 'Bearer ${localStorage.getItem('token')}'
      }),
    );

    final data = response.data;
    final List<Information> informations = [];
    for (var item in data['data']) {
      informations.add(Information.fromJson(item));
    }

    return informations;
  } on DioException catch (_) {
    return [];
  }
}

Future<Information?> getInformationById(String id) async {
  try {
    final response = await dio.get(
      '/api/informasi/$id',
      options: Options(headers: {
        'Authorization': 'Bearer ${localStorage.getItem('token')}'
      }),
    );

    final data = response.data;

    return Information.fromJson(data['data']);
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
