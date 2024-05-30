import 'package:moreway/core/api/paginated_page.dart';
import 'package:moreway/module/route/domain/dependency/i_route_repository.dart';
import 'package:moreway/module/route/domain/entity/route.dart';
import 'package:moreway/module/route/domain/entity/route_detailed.dart';
import 'package:moreway/module/user/domain/dependency/i_user_repository.dart';

class RouteInteractor {
  final IRouteRepository _routeRepository;
  final IUserRepository _userRepository;

  RouteInteractor(this._routeRepository, this._userRepository);

  Future<PaginatedPage<Route>> getRoutes({String? cursor}) {
    return _routeRepository.getRoutes(cursor: cursor);
  }

  Future<RouteDetailed> getRouteDetailed(String routeId) async {
    return _routeRepository.getRouteById(routeId);
  }

  Future<void> addToFavorite(String routeId) async {
    try {
      final userId = await _userRepository.getUserId();
      _routeRepository.addToFavorite(routeId, userId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeToFavorite(String routeId) async {
    try {
      final userId = await _userRepository.getUserId();
      _routeRepository.removeToFavorite(routeId, userId);
    } catch (e) {
      rethrow;
    }
  }
}
