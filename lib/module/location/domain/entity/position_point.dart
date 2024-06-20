import 'dart:math';

import 'package:latlong2/latlong.dart';

class PositionPoint {
  final double latitude;
  final double longitude;

  PositionPoint({
    required this.latitude,
    required this.longitude,
  });

  LatLng toLatLng(){
    return LatLng(latitude, longitude);
  }

  double distanceTo(PositionPoint other) {
    var p = 0.017453292519943295;
    var a = 0.5 - cos((other.latitude - latitude) * p)/2 + 
            cos(latitude * p) * cos(other.latitude * p) * 
            (1 - cos((other.longitude - longitude) * p))/2;
    return 12742 * asin(sqrt(a));
  }
}
