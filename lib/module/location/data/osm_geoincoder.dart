import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:moreway/core/api/geoincoder_api.dart';
import 'package:moreway/module/location/domain/dependency/i_geoincoder_service.dart';
import 'package:moreway/module/location/data/mapper/position_model.dart';
import 'package:moreway/module/location/domain/entity/position_point.dart';

@Singleton(as: IGeoincoderService)
class OSMGeoincoderService implements IGeoincoderService {
  final Dio _dio = Dio();

  OSMGeoincoderService();

  @override
  Future<String> getCity(PositionPoint position) async {
    try {
      final response = await _dio.get(GeoincoderApi.reverse, queryParameters: {
        "lat": position.latitude,
        "lon": position.longitude,
        "format": "json",
        "accept-language": "ru"
      });
      final data = response.data;
      if (data is Map<String, dynamic>) {
        final address = data['address'];
        if (address is Map<String, dynamic>) {
          final city = address['city'] ?? address['town'] ?? address['village'];
          if (city is String) {
            return city;
          }
        }
      }
      return "Вы где?";
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
