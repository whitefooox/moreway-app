// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';
import 'package:moreway/module/place/domain/entity/place_detailed.dart';

part 'place_detailed_model.g.dart';

@JsonSerializable()
class PlaceDetailedModel {
  final int id;
  final double distance;
  final String name;
  final double lat;
  final double lon;
  final double rating;
  final String description;

  @JsonKey(name: "images", fromJson: _imagesFromJson)
  final List<String> images;

  @JsonKey(name: "locality", fromJson: _localityFromJson)
  final String locality;

  @JsonKey(name: "type", fromJson: _typeFromJson)
  final String type;

  PlaceDetailedModel({
    required this.id,
    required this.distance,
    required this.name,
    required this.lat,
    required this.lon,
    required this.rating,
    required this.description,
    required this.images,
    required this.locality,
    required this.type,
  });

  static List<String> _imagesFromJson(List<dynamic> json) {
    return json.map((element) {
      final image = element as Map<String, dynamic>;
      return image['path'] as String;
    }).toList();
  }

  static String _localityFromJson(Map<String, dynamic> json) {
    return json['name'] as String;
  }

  static String _typeFromJson(Map<String, dynamic> json) {
    return json['name'] as String;
  }

  factory PlaceDetailedModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceDetailedModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceDetailedModelToJson(this);

  PlaceDetailed toPlaceDetailed() {
    return PlaceDetailed(
        id: id.toString(),
        distance: distance,
        name: name,
        lat: lat,
        lon: lon,
        rating: rating,
        images: images,
        location: locality,
        type: type,
        description: description);
  }
}
