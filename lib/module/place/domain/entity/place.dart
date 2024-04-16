class Place {
  final int id;
  final double distance;
  final String name;
  final double lat;
  final double lon;
  final double rating;
  final String image;
  final String location;

  Place({
    required this.id,
    required this.distance,
    required this.name,
    required this.lat,
    required this.lon,
    required this.rating,
    required this.image,
    required this.location,
  });

  factory Place.createFake() {
    return Place(
        id: 1,
        distance: 10,
        name: "name",
        lat: 10,
        lon: 10,
        rating: 5,
        image: "https://more-way.ru/storage/places/moscow_square.png",
        location: "Location");
  }
}
