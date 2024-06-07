import 'package:moreway/module/place/domain/entity/place.dart';
import 'package:moreway/module/place/domain/entity/place_base.dart';

class RoutePointDetailed {
  final String id;
  final int index;
  final PlaceBase place;
  final bool? isCompleted;
  
  RoutePointDetailed({
    required this.id,
    required this.index,
    required this.place,
    this.isCompleted
  });
}
