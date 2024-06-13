import 'package:moreway/module/location/domain/dependency/i_navigation_service.dart';
import 'package:moreway/module/location/domain/entity/position_point.dart';
import 'package:moreway/module/location/domain/entity/route_info.dart';

class NavigationInteractor {

  final INavigationService _navigationService;

  NavigationInteractor(this._navigationService);

  Future<RouteInfo> getRoute(List<PositionPoint> points) {
    return _navigationService.getRoute(points);
  }
}