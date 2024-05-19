import 'package:moreway/module/route/domain/dependency/i_route_builder_repository.dart';
import 'package:moreway/module/route/domain/entity/route.dart';
import 'package:moreway/module/route/domain/entity/route_raw.dart';
import 'package:moreway/module/user/domain/dependency/i_user_repository.dart';

class RouteBuilderInteractor {

  final IUserRepository _userRepository;
  final IRouteBuilderService _builderService;

  RouteBuilderInteractor(this._userRepository, this._builderService);

  Future<RouteRaw> getRoute() async {
    try {
      final userId = await _userRepository.getUserId();
      final routeRaw = await _builderService.getRoute(userId);
      return routeRaw;
    } catch (e) {
      rethrow;
    }
  }

  Future<RouteRaw> editRoute(List<String> placesId) async {
    try {
      final userId = await _userRepository.getUserId();
      final routeRaw = await _builderService.saveRoute(placesId, userId);
      return routeRaw;
    } catch (e) {
      rethrow;
    }
  }

  Future<Route> build(String name){
    throw UnimplementedError();
  }
}