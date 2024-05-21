import 'dart:developer';
import 'dart:ffi';

import 'package:moreway/core/api/api.dart';
import 'package:moreway/core/api/api_client.dart';
import 'package:moreway/module/place/domain/entity/place.dart';
import 'package:moreway/module/place/domain/entity/place_base.dart';
import 'package:moreway/module/route/data/mapping/indexed_place_model.dart';
import 'package:moreway/module/route/domain/dependency/i_route_builder_repository.dart';
import 'package:moreway/module/route/domain/entity/route.dart';
import 'package:moreway/module/route/domain/entity/route_raw.dart';

class RouteBuilderAPI implements IRouteBuilderService {
  final ApiClient _client;

  RouteBuilderAPI(this._client);

  @override
  Future<Route> build(String name, String userId) {
    // TODO: implement build
    throw UnimplementedError();
  }

  @override
  Future<RouteRaw> getRoute(String userId) async {
    try {
      final response = await _client.dio.get(Api.getConstructor(userId));
      final pointsJson = response.data['data']['items'] as List<dynamic>;
      log(pointsJson.toString());
      final points = pointsJson
          .map((pointJson) =>
              IndexedPlaceModel.fromJson(pointJson as Map<String, dynamic>))
          .toList();
      final routePoints = List<PlaceBase>.empty(growable: true);
      for (final point in points) {
        routePoints.insert(point.index - 1, point.place.toPlaceBase());
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
      final response = await _client.dio.put(Api.putConstructor(userId), data: {
        "items": placesId.indexed
            .map(
                (indexedId) => {"index": indexedId.$1 + 1, "placeId": indexedId.$2})
            .toList()
      });
      final pointsJson = response.data['data']['items'] as List<dynamic>;
      final points = pointsJson
          .map((pointJson) =>
              IndexedPlaceModel.fromJson(pointJson as Map<String, dynamic>))
          .toList();
      final routePoints = List<PlaceBase>.empty(growable: true);
      for (final point in points) {
        routePoints.insert(point.index - 1, point.place.toPlaceBase());
      }
      return RouteRaw(points: routePoints);
    } catch (e) {
      log("[route builder api] $e");
      rethrow;
    }
  }
}
