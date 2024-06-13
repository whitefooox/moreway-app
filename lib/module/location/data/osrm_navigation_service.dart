import 'dart:developer';

import 'package:moreway/module/location/domain/dependency/i_navigation_service.dart';
import 'package:moreway/module/location/domain/entity/position_point.dart';
import 'package:moreway/module/location/domain/entity/route_info.dart';
import 'package:osrm/osrm.dart';

class OsrmNavigationService implements INavigationService {
  final _osrm = Osrm();

  @override
  Future<RouteInfo> getRoute(List<PositionPoint> points) async {
    try {
      final response = await _osrm.route(RouteRequest(
          coordinates: points.map((e) => (e.longitude, e.latitude)).toList(),
          overview: OsrmOverview.full,
          profile: OsrmRequestProfile.foot));
      final resPoints = response.routes.first.geometry!.lineString!.coordinates
          .map((e) => PositionPoint(latitude: e.$2, longitude: e.$1))
          .toList();
      final distance = response.routes.first.distance!.toDouble();
      return RouteInfo(points: resPoints, distance: distance);
    } catch (e, stackTrace) {
      log("[osrm navigation service] $e", stackTrace: stackTrace);
      rethrow;
    }
  }
}
