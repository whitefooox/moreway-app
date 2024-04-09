import 'package:moreway/module/place/domain/entity/place.dart';

class PlacePage {
  final List<Place> places;
  final String? cursor;

  PlacePage({
    required this.places,
    this.cursor,
  });
}
