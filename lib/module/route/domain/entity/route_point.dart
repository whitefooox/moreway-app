import 'package:moreway/module/place/domain/entity/place.dart';
import 'package:moreway/module/place/domain/entity/place_base.dart';

class RoutePoint {
  final String id;
  final int index;
  final PlaceBase place; 

  RoutePoint({
    required this.id,
    required this.index,
    required this.place,
  });
}
