import 'package:json_annotation/json_annotation.dart';

import 'package:moreway/module/route/data/mapping/route_point_model.dart';
import 'package:moreway/module/route/domain/entity/route.dart';
import 'package:moreway/module/user/data/mapping/user_preview_model.dart';

part 'route_model.g.dart';

@JsonSerializable()
class RouteModel {
  final String id;
  final String name;
  final int points;
  final double rating;
  final List<RoutePointModel> routePoints;
  final UserPreviewModel creator;

  RouteModel({
    required this.id,
    required this.name,
    required this.points,
    required this.rating,
    required this.routePoints,
    required this.creator,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) =>
      _$RouteModelFromJson(json);

  Map<String, dynamic> toJson() => _$RouteModelToJson(this);

  Route toRoute() {
    return Route(
        id: id,
        name: name,
        rating: rating,
        points: routePoints
            .map((routePointModel) => routePointModel.toRoutePoint())
            .toList(),
        creator: creator.toUserPreview());
  }
}
