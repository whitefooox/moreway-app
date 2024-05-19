import 'package:moreway/module/route/domain/entity/route_point.dart';
import 'package:moreway/module/user/domain/entity/user_preview.dart';

class Route {
  final String id;
  final String name;
  final double rating;
  final List<RoutePoint> points;
  final UserPreview creator;

  Route({
    required this.id,
    required this.name,
    required this.rating,
    required this.points,
    required this.creator,
  });
}
