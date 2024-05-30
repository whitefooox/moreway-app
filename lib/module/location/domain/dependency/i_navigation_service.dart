import 'package:moreway/module/location/domain/entity/position_point.dart';

abstract class INavigationService {
  Future<List<PositionPoint>> getRoute(List<PositionPoint> points);
}