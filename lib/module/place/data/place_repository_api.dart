import 'dart:developer';

import 'package:moreway/core/api/api.dart';
import 'package:moreway/core/api/api_client.dart';
import 'package:moreway/core/api/paginated_page.dart';
import 'package:moreway/module/review/data/mapping/review_page_model.dart';
import 'package:moreway/module/review/domain/entity/review.dart';
import 'package:moreway/module/location/data/mapper/position_model.dart';
import 'package:moreway/module/location/domain/usecase/get_current_location.dart';
import 'package:moreway/module/place/data/mapping/place/place_detailed_model.dart';
import 'package:moreway/module/place/data/mapping/place/place_page_model.dart';
import 'package:moreway/module/place/data/place_query_parameters_builder.dart';
import 'package:moreway/module/place/domain/dependency/i_place_repository.dart';
import 'package:moreway/module/place/domain/entity/place.dart';
import 'package:moreway/module/place/domain/entity/place_detailed.dart';
import 'package:moreway/module/place/domain/entity/selected_place_filters.dart';

class PlaceRepositoryAPI implements IPlaceRepository {
  final ApiClient _client;
  final int _placesLimit = 8;
  final int _reviewsLimit = 8;
  final GetCurrentPositionUseCase _getCurrentPositionUseCase;

  PlaceRepositoryAPI(this._client, this._getCurrentPositionUseCase);

  @override
  Future<PaginatedPage<Place>> getPlaces(
      {String? cursor, SelectedPlaceFilters? filters}) async {
    log(filters.toString());
    try {
      final position = await _getCurrentPositionUseCase.execute();
      final positionModel = PositionModel.fromPositionPoint(position.point);
      final queryParameters = PlaceQueryParametersBuilder()
          .setPosition(positionModel)
          .setCursor(cursor)
          .setLimit(_placesLimit)
          .setFilters(filters)
          .build();
      final response =
          await _client.dio.get(Api.places, queryParameters: queryParameters);
      final json = response.data;
      return PlacePageModel.fromJson(json).toPlacePage();
    } catch (e) {
      log("[place repository api] $e");
      rethrow;
    }
  }

  @override
  Future<PlaceDetailed> getPlaceById(String id) async {
    try {
      final position = await _getCurrentPositionUseCase.execute();
      final positionModel = PositionModel.fromPositionPoint(position.point);
      final queryParameters =
          PlaceQueryParametersBuilder().setPosition(positionModel).build();
      final response = await _client.dio
          .get(Api.getPlace(id), queryParameters: queryParameters);
      final json = response.data['data'];
      return PlaceDetailedModel.fromJson(json).toPlaceDetailed();
    } catch (e) {
      log("[place repository api] $e");
      rethrow;
    }
  }

  @override
  Future<PaginatedPage<Review>> getReviews(
      {String? cursor, required String placeId}) async {
    try {
      final response = await _client.dio.get(Api.getPlaceReviews(placeId),
          queryParameters: {"cursor": cursor, "limit": _reviewsLimit.toString()}
            ..removeWhere((key, value) => value == null));
      final json = response.data; 
      return ReviewPageModel.fromJson(json).toReviewPage();
    } catch (e) {
      log("[place repository api] $e");
      rethrow;
    }
  }
}
