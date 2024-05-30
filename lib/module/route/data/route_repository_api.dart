import 'dart:developer';

import 'package:moreway/core/api/api.dart';
import 'package:moreway/core/api/api_client.dart';
import 'package:moreway/core/api/paginated_page.dart';
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
}
