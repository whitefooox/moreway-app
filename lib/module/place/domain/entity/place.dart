
class Place {
  final int id;
  final double distance;
  final String name;
  final double lat;
  final double lon;
  final double rating;
  final String description;
  final List<String> images;
  final String location;
  Place({
    required this.id,
    required this.distance,
    required this.name,
    required this.lat,
    required this.lon,
    required this.rating,
    required this.description,
    required this.images,
    required this.location,
  });
}
