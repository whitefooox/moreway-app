import 'package:json_annotation/json_annotation.dart';

part 'place_filter_options_model.g.dart';

@JsonSerializable()
class PlaceFilterOptionsModel {
  final List<String> localities;
  final List<String> types;
  final int minDistance;
  final int maxDistance;

  PlaceFilterOptionsModel({
    required this.localities,
    required this.types,
    required this.minDistance,
    required this.maxDistance,
  });

  Map<String, dynamic> toJson() => _$PlaceFilterOptionsModelToJson(this);

  factory PlaceFilterOptionsModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceFilterOptionsModelFromJson(json);
}
