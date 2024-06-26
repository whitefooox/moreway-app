import 'package:json_annotation/json_annotation.dart';

import 'package:moreway/module/place/data/mapping/place/place_model.dart';
import 'package:moreway/module/place/data/mapping/place/place_route_model.dart';
import 'package:moreway/module/route/domain/entity/route_point.dart';

part 'route_point_model.g.dart';

@JsonSerializable()
class RoutePointModel {
  final int id;
  final String image;

  RoutePointModel({
    required this.id,
    required this.image,
  });

  factory RoutePointModel.fromJson(Map<String, dynamic> json) =>
      _$RoutePointModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoutePointModelToJson(this);

  RoutePoint toRoutePoint() {
    return RoutePoint(id: id.toString(), image: image);
  }
}
