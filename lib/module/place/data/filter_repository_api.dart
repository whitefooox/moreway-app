import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:moreway/core/api/api.dart';
import 'package:moreway/core/di/inject.dart';
import 'package:moreway/module/place/data/mapping/place_filter_options_model.dart';
import 'package:moreway/module/place/domain/dependency/i_filter_repository.dart';
import 'package:moreway/module/place/domain/entity/place_filter_options.dart';

@Environment(Env.prod)
@Singleton(as: IFilterRepository)
class FilterRepositoryAPI implements IFilterRepository {
  final Dio _dio;

  FilterRepositoryAPI(this._dio);

  @override
  Future<PlaceFilterOptions> getAll() async {
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
