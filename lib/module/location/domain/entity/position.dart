import 'package:json_annotation/json_annotation.dart';

part 'position.g.dart';

@JsonSerializable()
class Position {

  @JsonKey(name: "lat")
  final double latitude;

  @JsonKey(name: "lon")
  final double longitude;

  Position({
    required this.latitude,
    required this.longitude,
  });

  factory Position.fromJson(Map<String, dynamic> json) => _$PositionFromJson(json);

  Map<String, dynamic> toJson() => _$PositionToJson(this);
}
