import 'package:moreway/module/route/domain/entity/route.dart';
import 'package:moreway/module/route/domain/entity/route_detailed.dart';
import 'package:moreway/module/route/domain/entity/route_raw.dart';

abstract class IRouteBuilderService {
  Future<RouteRaw> saveRoute(List<String> placesId, String userId);
  Future<RouteRaw> getRoute(String userId);
  Future<RouteDetailed> build(String name, String userId);
}