// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:latlong2/latlong.dart';
import 'package:moreway/module/location/domain/entity/position_point.dart';

class Position {
  final PositionPoint point;
  final double heading;

  Position({
    required this.point,
    required this.heading,
  });

  LatLng toLatLng(){
    return point.toLatLng();
  }
}
