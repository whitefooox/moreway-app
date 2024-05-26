// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:moreway/module/place/domain/entity/place.dart';
import 'package:moreway/module/place/domain/entity/place_base.dart';

part 'place_route_model.g.dart';

@JsonSerializable()
class PlaceRouteModel {
  final int id;
  final String name;
  final double lat;
  final double lon;
  final double rating;

  @JsonKey(name: "image", fromJson: _imageFromJson)
  final String image;

  @JsonKey(name: "locality", fromJson: _localityFromJson)
  final String locality;

  @JsonKey(name: "type", fromJson: _typeFromJson)
  final String type;

  PlaceRouteModel(
      {required this.id,
      required this.name,
      required this.lat,
      required this.lon,
      required this.rating,
      required this.image,
      required this.locality,
      required this.type});

  static String _imageFromJson(Map<String, dynamic> json) {
    return json["path"] as String;
  }

  static String _typeFromJson(Map<String, dynamic> json) {
    return json["name"] as String;
  }

  static String _localityFromJson(Map<String, dynamic> json) {
    return json["name"] as String;
  }

  factory PlaceRouteModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceRouteModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceRouteModelToJson(this);

  @override
  String toString() {
    return 'PlaceRouteModel(id: $id, name: $name, lat: $lat, lon: $lon, rating: $rating, image: $image, locality: $locality)';
  }

  PlaceBase toPlaceBase() {
    return PlaceBase(
        id: id.toString(),
        name: name,
        lat: lat,
        lon: lon,
        rating: rating,
        image: image,
        location: locality);
  }
}
