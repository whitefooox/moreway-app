import 'package:moreway/core/api/paginated_page.dart';
import 'package:moreway/module/location/domain/entity/position_point.dart';
import 'package:moreway/module/route/domain/entity/route.dart';
import 'package:moreway/module/route/domain/entity/route_detailed.dart';

abstract class IRouteRepository {
  Future<PaginatedPage<Route>> getRoutes({String? cursor});
  Future<RouteDetailed> getRouteById(String id);
  Future<void> addToFavorite(String routeId, String userId);
  Future<void> removeToFavorite(String routeId, String userId);
  Future<PaginatedPage<Route>> getFavoriteRoutes({String? cursor, required String userId});
  Future<PaginatedPage<Route>> getCreatedRoutes({String? cursor, required String userId});
  Future<RouteDetailed?> getActiveRoute(String userId);
  Future<RouteDetailed> setActiveRoute(String routeId, String userId);
  Future<void> completeRoutePoint(String routeId, String userId, PositionPoint position);
}