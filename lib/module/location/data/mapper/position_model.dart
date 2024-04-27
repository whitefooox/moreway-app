import 'package:json_annotation/json_annotation.dart';
import 'package:moreway/module/location/domain/entity/position_point.dart';

part 'position_model.g.dart';

@JsonSerializable()
class PositionModel {
  @JsonKey(name: "lat")
  final double latitude;

  @JsonKey(name: "lon")
  final double longitude;

  PositionModel({
    required this.latitude,
    required this.longitude,
  });

  factory PositionModel.fromJson(Map<String, dynamic> json) =>
      _$PositionModelFromJson(json);

  Map<String, dynamic> toJson() => _$PositionModelToJson(this);

  factory PositionModel.fromPositionPoint(PositionPoint point) {
    return PositionModel(latitude: point.latitude, longitude: point.longitude);
  }
}
