import 'dart:developer';

import 'package:moreway/core/api/api.dart';
import 'package:moreway/core/api/api_client.dart';
import 'package:moreway/module/place/data/mapping/filter/place_filter_options_model.dart';
import 'package:moreway/module/place/domain/dependency/i_filter_repository.dart';
import 'package:moreway/module/place/domain/entity/place_filter_options.dart';

class FilterRepositoryAPI implements IFilterRepository {
  final ApiClient _client;

  FilterRepositoryAPI(this._client);

  @override
  Future<PlaceFilterOptions> getAll() async {
    try {
      final response = await _client.dio.get(Api.getPlaceFilters);
      final json = response.data['data'];
      final filtersModel = PlaceFilterOptionsModel.fromJson(json);
      return PlaceFilterOptions(
          localities: filtersModel.localities,
          types: filtersModel.types,
          rangeDistance: [filtersModel.minDistance, filtersModel.maxDistance],
          rangeRating: [0, 5]);
    } catch (e, stackTrace) {
      log(e.toString(), stackTrace: stackTrace);
      rethrow;
    }
  }
}
