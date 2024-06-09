import 'package:moreway/module/route/domain/dependency/i_route_repository.dart';
import 'package:moreway/module/route/domain/entity/route_detailed.dart';
import 'package:moreway/module/user/domain/dependency/i_user_repository.dart';

class ActiveRouteInteractor {
  final IRouteRepository _routeRepository;
  final IUserRepository _userRepository;

  ActiveRouteInteractor(this._routeRepository, this._userRepository);

  Future<RouteDetailed?> getActiveRoute() async {
    try {
      final userId = await _userRepository.getUserId();
      return _routeRepository.getActiveRoute(userId);
    } catch (e) {
      rethrow;
    }
  }

  Future<RouteDetailed> setActiveRoute(String routeId) async {
    try {
      final userId = await _userRepository.getUserId();
      return _routeRepository.setActiveRoute(routeId, userId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> passPoint() async {}
}
