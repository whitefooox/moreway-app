import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:moreway/core/api/api.dart';
import 'package:moreway/core/api/api_client.dart';
import 'package:moreway/core/api/paginated_page.dart';
import 'package:moreway/module/location/domain/entity/position_point.dart';
import 'package:moreway/module/route/data/mapping/route_detailed_model.dart';
import 'package:moreway/module/route/data/mapping/route_page_model.dart';
import 'package:moreway/module/route/domain/dependency/i_route_repository.dart';
import 'package:moreway/module/route/domain/entity/route.dart';
import 'package:moreway/module/route/domain/entity/route_detailed.dart';

class RouteRepositoryAPI implements IRouteRepository {
  final ApiClient _client;
  final int _routesLimit = 8;

  RouteRepositoryAPI(this._client);

  @override
  Future<PaginatedPage<Route>> getRoutes({String? cursor}) async {
    try {
      final response = await _client.dio.get(Api.routes,
          queryParameters: {"limit": _routesLimit, "cursor": cursor});
      final json = response.data;
      return RoutePageModel.fromJson(json).toRoutePage();
    } catch (e, stacktrace) {
      log("[route repository api] $e", stackTrace: stacktrace);
      rethrow;
    }
  }

  @override
  Future<RouteDetailed> getRouteById(String id) async {
    try {
      final response = await _client.dio.get(Api.routesRoutesId(id));
      final json = response.data['data'];
      return RouteDetailedModel.fromJson(json).toRouteDetailed();
    } catch (e, stackTrace) {
      log("[route repository api] $e", stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> addToFavorite(String routeId, String userId) async {
    try {
      final response = await _client.dio
          .post(Api.favoriteRoutes(userId), data: {"routeId": routeId});
    } catch (e, stackTrace) {
      log("[route repository api] $e", stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> removeToFavorite(String routeId, String userId) async {
    try {
      final response =
          await _client.dio.delete(Api.favoriteRoutesRouteId(userId, routeId));
    } catch (e, stackTrace) {
      log("[route repository api] $e", stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<RouteDetailed?> getActiveRoute(String userId) async {
    try {
      final response = await _client.dio.get(Api.getActiveRoute(userId));
      final json = response.data['data'];
      return RouteDetailedModel.fromJson(json).toRouteDetailed();
    } on DioException catch (e, stackTrace) {
      if (e.type == DioExceptionType.badResponse) {
        return null;
      } else {
        log("[route repository api] $e", stackTrace: stackTrace);
        rethrow;
      }
    } catch (e, stackTrace) {
      log("[route repository api] $e", stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<RouteDetailed> setActiveRoute(String routeId, String userId) async {
    try {
      final response = await _client.dio
          .put(Api.getActiveRoute(userId), data: {"routeId": routeId});
      final json = response.data['data'];
      return RouteDetailedModel.fromJson(json).toRouteDetailed();
    } catch (e, stackTrace) {
      log("[route repository api] $e", stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> completeRoutePoint(String routeId, String userId, PositionPoint position) async {
        try {
       await _client.dio
          .put(Api.completeRoutePoint, data: {
            "routeId": routeId,
            "userId": userId,
            "lat": position.latitude,
            "lon": position.longitude
      });
    } catch (e, stackTrace) {
      log("[route repository api] $e", stackTrace: stackTrace);
      rethrow;
    }
  }
  
  @override
  Future<PaginatedPage<Route>> getFavoriteRoutes({String? cursor, required String userId}) async {
    try {
      final response = await _client.dio.get(Api.getFavoriteRoutes(userId),
          queryParameters: {"limit": _routesLimit, "cursor": cursor});
      final json = response.data;
      return RoutePageModel.fromJson(json).toRoutePage();
    } catch (e, stacktrace) {
      log("[route repository api] $e", stackTrace: stacktrace);
      rethrow;
    }
  }
  
  @override
  Future<PaginatedPage<Route>> getCreatedRoutes({String? cursor, required String userId}) async {
    try {
      final response = await _client.dio.get(Api.getCreatedRoutes(userId),
          queryParameters: {"limit": _routesLimit, "cursor": cursor});
      final json = response.data;
      return RoutePageModel.fromJson(json).toRoutePage();
    } catch (e, stacktrace) {
      log("[route repository api] $e", stackTrace: stacktrace);
      rethrow;
    }
  }
}
