import 'package:geolocator/geolocator.dart';
import 'package:moreway/module/location/domain/dependency/i_location_service.dart';
import 'package:moreway/module/location/domain/entity/position.dart' as domain;
import 'package:moreway/module/location/domain/entity/position_point.dart';

class GeolocatorService implements ILocationService {
  @override
  Future<domain.Position> getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();
    return domain.Position(
        point: PositionPoint(
            latitude: position.latitude, longitude: position.longitude),
        heading: position.heading);
  }

  @override
  Stream<domain.Position> getLocationStream() {
    return Geolocator.getPositionStream().map((position) => domain.Position(
        point: PositionPoint(
            latitude: position.latitude, longitude: position.longitude),
        heading: position.heading));
  }
}
