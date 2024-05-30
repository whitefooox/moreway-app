import 'package:moreway/module/route/domain/entity/route_point_detailed.dart';
import 'package:moreway/module/user/domain/entity/user_preview.dart';

class RouteDetailed {
  final String id;
  final String name;
  final double rating;
  final List<RoutePointDetailed> points;
  final UserPreview creator;

  RouteDetailed({
    required this.id,
    required this.name,
    required this.rating,
    required this.points,
    required this.creator,
  });
}
