import 'package:moreway/module/location/domain/entity/position_point.dart';

class RouteInfo {
  final List<PositionPoint> points;
  final double distance;
  
  RouteInfo({
    required this.points,
    required this.distance,
  });
}
