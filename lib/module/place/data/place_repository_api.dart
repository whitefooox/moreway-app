import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:moreway/core/api/api.dart';
import 'package:moreway/module/location/domain/usecase/get_current_location.dart';
import 'package:moreway/module/place/data/mapping/place_page_model.dart';
import 'package:moreway/module/place/data/place_query_parameters_builder.dart';
import 'package:moreway/module/place/domain/dependency/i_place_repository.dart';
import 'package:moreway/module/place/domain/entity/place_filters.dart';
import 'package:moreway/module/place/domain/entity/place_page.dart';

@Singleton(as: IPlaceRepository)
class PlaceRepositoryAPI implements IPlaceRepository {
  final Dio _dio;
  final int limit = 8;
  final GetCurrentPositionUseCase _getCurrentPositionUseCase;

  PlaceRepositoryAPI(this._dio, this._getCurrentPositionUseCase);

  @override
  Future<PlacePage> get({String? cursor, PlaceFilters? filters}) async {
    try {
      final position = await _getCurrentPositionUseCase.execute();
      final queryParameters = PlaceQueryParametersBuilder()
          .setPosition(position)
          .setCursor(cursor)
          .setLimit(limit)
          .setFilters(filters)
          .build();
      final response =
          await _dio.get(Api.places, queryParameters: queryParameters);
      final json = response.data;
      return PlacePageModel.fromJson(json).toPlacePage();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
