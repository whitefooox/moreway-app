import 'package:moreway/module/location/domain/entity/position_point.dart';
import 'package:moreway/module/location/domain/entity/route_info.dart';

abstract class INavigationService {
  Future<RouteInfo> getRoute(List<PositionPoint> points);
}