import 'package:moreway/module/place/domain/entity/place.dart';

class RoutePoint {
  final String id;
  final String index;
  final Place place; 

  RoutePoint({
    required this.id,
    required this.index,
    required this.place,
  });
}
