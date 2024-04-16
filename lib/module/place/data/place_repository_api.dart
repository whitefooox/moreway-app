import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:moreway/core/api/api.dart';
import 'package:moreway/module/location/domain/usecase/get_current_location.dart';
import 'package:moreway/module/place/data/mapping/place_filter_options_model.dart';
import 'package:moreway/module/place/data/mapping/place_page_model.dart';
import 'package:moreway/module/place/data/place_query_parameters_builder.dart';
import 'package:moreway/module/place/domain/dependency/i_place_repository.dart';
import 'package:moreway/module/place/domain/entity/place_filter_options.dart';
import 'package:moreway/module/place/domain/entity/place_page.dart';
import 'package:moreway/module/place/domain/entity/selected_place_filters.dart';

@Singleton(as: IPlaceRepository)
class PlaceRepositoryAPI implements IPlaceRepository {
  final Dio _dio;
  final int limit = 8;
  final GetCurrentPositionUseCase _getCurrentPositionUseCase;

  PlaceRepositoryAPI(this._dio, this._getCurrentPositionUseCase);

  @override
  Future<PlacePage> getPlaces(
      {String? cursor, SelectedPlaceFilters? filters}) async {
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
    //return PlacePage(places: [], cursor: null);
  }

  @override
  Future<PlaceFilterOptions> getFilters() async {
    // return PlaceFilterOptions(
    //     localities: ["Кемерово", "Яя"],
    //     types: [],
    //     rangeDistance: [0, 100],
    //     rangeRating: [0, 5]);
    try {
      final response = await _dio.get(Api.getPlaceFilters);
      final json = response.data['data'];
      final filtersModel = PlaceFilterOptionsModel.fromJson(json);
      return PlaceFilterOptions(
          localities: filtersModel.localities,
          types: filtersModel.types,
          rangeDistance: [filtersModel.minDistance, filtersModel.maxDistance],
          rangeRating: [0, 5]);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
