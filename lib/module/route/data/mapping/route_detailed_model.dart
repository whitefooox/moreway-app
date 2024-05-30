import 'package:json_annotation/json_annotation.dart';

import 'package:moreway/module/route/data/mapping/route_point_detailed_model.dart';
import 'package:moreway/module/route/domain/entity/route_detailed.dart';
import 'package:moreway/module/user/data/mapping/user_preview_model.dart';

part 'route_detailed_model.g.dart';

@JsonSerializable()
class RouteDetailedModel {
  final int id;
  final String name;
  final double rating;
  final List<RoutePointDetailedModel> routePoints;
  final UserPreviewModel creator;
  final bool isActive;
  final bool isFavorite;

  RouteDetailedModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.routePoints,
    required this.creator,
    required this.isActive,
    required this.isFavorite
  });

  factory RouteDetailedModel.fromJson(Map<String, dynamic> json) =>
      _$RouteDetailedModelFromJson(json);

  Map<String, dynamic> toJson() => _$RouteDetailedModelToJson(this);

  RouteDetailed toRouteDetailed() {
    return RouteDetailed(
        id: id.toString(),
        name: name,
        rating: rating,
        points: routePoints.map((e) => e.toRoutePointDetailed()).toList(),
        creator: creator.toUserPreview(),
        isActive: isActive,
        isFavorite: isFavorite
        );
  }
}
