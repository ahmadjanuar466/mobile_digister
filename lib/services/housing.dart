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

Future<List<BlockModel>> getBlocks() async {
  try {
    final response = await dio.get(
      '/api/registrasi/blok',
      options: Options(headers: {
        'Authorization': 'Bearer ${localStorage.getItem('token')}'
      }),
    );

    final data = response.data;
    final List<BlockModel> blocks = [];
    for (var item in data['data']) {
      blocks.add(BlockModel.fromJson(item));
    }

    return blocks;
  } on DioException catch (_) {
    return [];
  }
}

Future<List<HousingModel>> getHousings() async {
  try {
    final response = await dio.get(
      '/api/registrasi/perumahan',
      options: Options(headers: {
        'Authorization': 'Bearer ${localStorage.getItem('token')}'
      }),
    );

    final data = response.data;
    final List<HousingModel> housings = [];
    for (var item in data['data']) {
      housings.add(HousingModel.fromJson(item));
    }

    return housings;
  } on DioException catch (_) {
    return [];
  }
}

Future<List<SecurityModel>> getSecurity() async {
  try {
    final response = await dio.get(
      '/api/warga/security',
      options: Options(headers: {
        'Authorization': 'Bearer ${localStorage.getItem('token')}'
      }),
    );

    final data = response.data;
    final List<SecurityModel> securities = [];
    for (var item in data['data']) {
      securities.add(SecurityModel.fromJson(item));
    }

    return securities;
  } on DioException catch (_) {
    return [];
  }
}

Future<List<CCTVModel>> getCCTV(String block) async {
  try {
    final response = await dio.post(
      '/api/warga/cctv',
      options: Options(headers: {
        'Authorization': 'Bearer ${localStorage.getItem('token')}'
      }),
      data: jsonEncode({'blok': block}),
    );

    final data = response.data;
    final List<CCTVModel> cctvs = [];
    for (var item in data['data']) {
      cctvs.add(CCTVModel.fromJson(item));
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

Future<List<InformationModel>> getInformations() async {
  try {
    final response = await dio.get(
      '/api/informasi',
      options: Options(headers: {
        'Authorization': 'Bearer ${localStorage.getItem('token')}'
      }),
    );

    final data = response.data;
    final List<InformationModel> informations = [];
    for (var item in data['data']) {
      informations.add(InformationModel.fromJson(item));
    }

    return informations;
  } on DioException catch (_) {
    return [];
  }
}
