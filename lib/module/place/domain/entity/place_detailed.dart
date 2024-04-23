// ignore_for_file: public_member_api_docs, sort_constructors_first
class PlaceDetailed {
  final String id;
  final double distance;
  final String name;
  final double lat;
  final double lon;
  final double rating;
  final List<String> images;
  final String location;
  final String type;
  final String description;

  PlaceDetailed({
    required this.id,
    required this.distance,
    required this.name,
    required this.lat,
    required this.lon,
    required this.rating,
    required this.images,
    required this.location,
    required this.type,
    required this.description,
  });

  PlaceDetailed copyWith({
    String? id,
    double? distance,
    String? name,
    double? lat,
    double? lon,
    double? rating,
    List<String>? images,
    String? location,
    String? type,
    String? description,
  }) {
    return PlaceDetailed(
      id: id ?? this.id,
      distance: distance ?? this.distance,
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      rating: rating ?? this.rating,
      images: images ?? this.images,
      location: location ?? this.location,
      type: type ?? this.type,
      description: description ?? this.description,
    );
  }

  factory PlaceDetailed.createFake() {
    return PlaceDetailed(
      id: "1",
      distance: 10,
      name: "name",
      lat: 10,
      lon: 10,
      rating: 5,
      images: ["https://bellard.org/bpg/2.png"],
      location: "Location",
      type: '',
      description: '',
    );
  }
}
