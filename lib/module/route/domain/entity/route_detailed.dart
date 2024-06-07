import 'package:moreway/module/route/domain/entity/route_point_detailed.dart';
import 'package:moreway/module/user/domain/entity/user_preview.dart';

class RouteDetailed {
  final String id;
  final String name;
  final double rating;
  final List<RoutePointDetailed> points;
  final UserPreview creator;
  final bool? isFavorite;
  final bool? isActive;

  RouteDetailed(
      {required this.id,
      required this.name,
      required this.rating,
      required this.points,
      required this.creator,
      this.isActive,
      this.isFavorite});

  RouteDetailed copyWith({
    String? id,
    String? name,
    double? rating,
    List<RoutePointDetailed>? points,
    UserPreview? creator,
    bool? isFavorite,
    bool? isActive,
  }) {
    return RouteDetailed(
      id: id ?? this.id,
      name: name ?? this.name,
      rating: rating ?? this.rating,
      points: points ?? this.points,
      creator: creator ?? this.creator,
      isFavorite: isFavorite ?? this.isFavorite,
      isActive: isActive ?? this.isActive,
    );
  }
}
