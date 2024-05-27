import 'dart:developer';

import 'package:moreway/core/api/api.dart';
import 'package:moreway/core/api/api_client.dart';
import 'package:moreway/core/api/paginated_page.dart';
import 'package:moreway/module/route/data/mapping/route_page_model.dart';
import 'package:moreway/module/route/domain/dependency/i_route_repository.dart';
import 'package:moreway/module/route/domain/entity/route.dart';

class RouteRepositoryAPI implements IRouteRepository {
  final ApiClient _client;
  final int _routesLimit = 8;

  RouteRepositoryAPI(this._client);

  @override
  Future<PaginatedPage<Route>> getRoutes({String? cursor}) async {
    try {
      final response = await _client.dio.get(Api.routes, queryParameters: {
        "limit": _routesLimit
      });
      final json = response.data;
      return RoutePageModel.fromJson(json).toRoutePage();
    } catch (e, stacktrace) {
      log("[route repository api] $e", stackTrace: stacktrace);
      rethrow;
    }
  }
}
