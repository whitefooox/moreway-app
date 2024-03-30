import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:moreway/core/api/geoincoder_api.dart';
import 'package:moreway/module/location/domain/dependency/i_geoincoder_service.dart';
import 'package:moreway/module/location/domain/entity/position.dart';

@Singleton(as: IGeoincoderService)
class OSMGeoincoderService implements IGeoincoderService {

  final Dio _dio = Dio();

  OSMGeoincoderService();

  @override
  Future<String> getCity(Position position) async {
    try {
      final response = await _dio.get(GeoincoderApi.reverse, queryParameters: {
        "lat": position.latitude,
        "lon": position.longitude,
        "format": "json",
        "accept-language": "ru"
      });
      return response.data["address"]["town"];
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}