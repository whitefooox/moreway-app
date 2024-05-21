import 'package:json_annotation/json_annotation.dart';
import 'package:moreway/module/place/data/mapping/place/place_model.dart';
import 'package:moreway/module/place/data/mapping/place/place_route_model.dart';

part 'indexed_place_model.g.dart';

@JsonSerializable()
class IndexedPlaceModel {
  final int index;
  final PlaceRouteModel place;

  IndexedPlaceModel({
    required this.index,
    required this.place,
  });

  factory IndexedPlaceModel.fromJson(Map<String, dynamic> json) =>
      _$IndexedPlaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$IndexedPlaceModelToJson(this);
}
