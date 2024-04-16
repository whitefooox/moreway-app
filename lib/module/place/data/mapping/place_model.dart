// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';
import 'package:moreway/module/place/domain/entity/place.dart';

part 'place_model.g.dart';

@JsonSerializable()
class PlaceModel {
  final int id;
  final String name;
  final double lat;
  final double lon;
  final double rating;

  @JsonKey(name: "image", fromJson: _imageFromJson)
  final String image;

  final double distance;

  @JsonKey(name: "locality", fromJson: _localityFromJson)
  final String locality;

  PlaceModel({
    required this.id,
    required this.name,
    required this.lat,
    required this.lon,
    required this.rating,
    required this.image,
    required this.distance,
    required this.locality,
  });

  static String _imageFromJson(Map<String, dynamic> json) {
    return json["path"] as String;
  }

  static String _localityFromJson(Map<String, dynamic> json) {
    return json["name"] as String;
  }

  factory PlaceModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceModelToJson(this);

  @override
  String toString() {
    return 'PlaceModel(id: $id, name: $name, lat: $lat, lon: $lon, rating: $rating, image: $image, distance: $distance, locality: $locality)';
  }

  Place toPlace() {
    return Place(
        id: id,
        distance: distance,
        name: name,
        lat: lat,
        lon: lon,
        rating: rating,
        image: image,
        location: locality);
  }
}
