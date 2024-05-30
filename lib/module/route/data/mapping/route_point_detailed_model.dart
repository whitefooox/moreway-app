import 'package:json_annotation/json_annotation.dart';
import 'package:moreway/module/place/data/mapping/place/place_route_model.dart';
import 'package:moreway/module/place/domain/entity/place_base.dart';
import 'package:moreway/module/route/domain/entity/route_point_detailed.dart';

part 'route_point_detailed_model.g.dart';

@JsonSerializable()
class RoutePointDetailedModel {
  final int id;
  final int index;
  final PlaceRouteModel place;

  RoutePointDetailedModel({
    required this.id,
    required this.index,
    required this.place,
  });

  factory RoutePointDetailedModel.fromJson(Map<String, dynamic> json) =>
      _$RoutePointDetailedModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoutePointDetailedModelToJson(this);

  RoutePointDetailed toRoutePointDetailed() {
    return RoutePointDetailed(id: id.toString(), index: index, place: place.toPlaceBase());
  }
}
