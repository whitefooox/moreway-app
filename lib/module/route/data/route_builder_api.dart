import 'dart:developer';
import 'dart:ffi';

import 'package:moreway/core/api/api.dart';
import 'package:moreway/core/api/api_client.dart';
import 'package:moreway/module/location/domain/usecase/get_current_location.dart';
import 'package:moreway/module/place/domain/entity/place.dart';
import 'package:moreway/module/place/domain/entity/place_base.dart';
import 'package:moreway/module/route/data/mapping/indexed_place_model.dart';
import 'package:moreway/module/route/data/mapping/route_model.dart';
import 'package:moreway/module/route/domain/dependency/i_route_builder_repository.dart';
import 'package:moreway/module/route/domain/entity/route.dart';
import 'package:moreway/module/route/domain/entity/route_raw.dart';

class RouteBuilderAPI implements IRouteBuilderService {
  final ApiClient _client;
  final GetCurrentPositionUseCase _getCurrentPositionUseCase;

  RouteBuilderAPI(this._client, this._getCurrentPositionUseCase);

  @override
  Future<Route> build(String name, String userId) async {
    try {
      final response = await _client.dio
          .post(Api.routes, data: {"name": name, "userId": userId});
      final json = response.data['data'];
      return RouteModel.fromJson(json).toRoute();
    } catch (e, stacktrace) {
      log("[route builder api] $e", stackTrace: stacktrace);
      rethrow;
    }
  }

  @override
  Future<RouteRaw> getRoute(String userId) async {
    try {
      final position = await _getCurrentPositionUseCase.execute();
      final response = await _client.dio.get(Api.getConstructor(userId),
          queryParameters: {
            "lat": position.point.latitude,
            "lon": position.point.longitude
          });
      final pointsJson = response.data['data']['items'] as List<dynamic>;
      log(pointsJson.toString());
      final points = pointsJson
          .map((pointJson) =>
              IndexedPlaceModel.fromJson(pointJson as Map<String, dynamic>))
          .toList();
      final routePoints = List<Place>.empty(growable: true);
      for (final point in points) {
        routePoints.insert(point.index - 1, point.place.toPlace());
      }
      return RouteRaw(points: routePoints);
    } catch (e, stacktrace) {
      log("error", stackTrace: stacktrace);
      log("[route builder api] $e");
      rethrow;
    }
  }

  @override
  Future<RouteRaw> saveRoute(List<String> placesId, String userId) async {
    try {
      final position = await _getCurrentPositionUseCase.execute();
      final response = await _client.dio.put(Api.putConstructor(userId), data: {
        "items": placesId.indexed
            .map((indexedId) =>
                {"index": indexedId.$1 + 1, "placeId": indexedId.$2})
            .toList()
      }, queryParameters: {
        "lat": position.point.latitude,
        "lon": position.point.longitude
      });
      final pointsJson = response.data['data']['items'] as List<dynamic>;
      final points = pointsJson
          .map((pointJson) =>
              IndexedPlaceModel.fromJson(pointJson as Map<String, dynamic>))
          .toList();
      final routePoints = List<Place>.empty(growable: true);
      for (final point in points) {
        routePoints.insert(point.index - 1, point.place.toPlace());
      }
      return RouteRaw(points: routePoints);
    } catch (e) {
      log("[route builder api] $e");
      rethrow;
    }
  }
}
