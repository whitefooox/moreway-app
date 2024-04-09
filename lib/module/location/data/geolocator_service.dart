import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:moreway/module/location/domain/dependency/i_location_service.dart';
import 'package:moreway/module/location/domain/entity/position.dart' as domain;

@Singleton(as: ILocationService)
class GeolocatorService implements ILocationService {
  @override
  Future<domain.Position> getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();
    return domain.Position(latitude: position.latitude, longitude: position.longitude);
  }
}