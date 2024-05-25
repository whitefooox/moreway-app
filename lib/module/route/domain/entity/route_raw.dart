import 'package:moreway/module/place/domain/entity/place.dart';
import 'package:moreway/module/place/domain/entity/place_base.dart';

class RouteRaw {
  final List<Place> points;

  RouteRaw({
    required this.points,
  });

  List<String> toPlacesId(){
    return points.map((e) => e.id).toList();
  }
}
