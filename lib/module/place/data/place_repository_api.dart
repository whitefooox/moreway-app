import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:moreway/core/api/api.dart';
import 'package:moreway/module/location/domain/entity/position.dart';
import 'package:moreway/module/location/domain/usecase/get_current_location.dart';
import 'package:moreway/module/place/data/mapping/place_model.dart';
import 'package:moreway/module/place/domain/dependency/i_place_repository.dart';
import 'package:moreway/module/place/domain/entity/place.dart';

@Singleton(as: IPlaceRepository)
class PlaceRepositoryAPI implements IPlaceRepository {

  final Dio _dio;
  final GetCurrentPositionUseCase _getCurrentPositionUseCase;

  PlaceRepositoryAPI(this._dio, this._getCurrentPositionUseCase);

  @override
  Future<List<Place>> getAll() async {
    Position position;
    try {
      position = await _getCurrentPositionUseCase.execute();
    } catch (e) {
      return Future.error(e);
    }
    List<Place> places = [];
    try {
      final response = await _dio.get(Api.places, queryParameters: position.toJson());
      final placesJson = response.data['data'] as List<dynamic>;
      for (var element in placesJson) {
        final placeJson = element as Map<String, dynamic>;
        final place = PlaceModel.fromJson(placeJson);
        places.add(place.toPlace());
      }
    } catch (e) {
      log(e.toString());
    }
    return places;
  }
}