import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:moreway/module/location/domain/dependency/i_location_permission_service.dart';
import 'package:moreway/module/location/domain/entity/location_permission_status.dart';

@Singleton(as: ILocationPermissionService)
class GeolocatorPermissionService implements ILocationPermissionService {
  @override
  Future<bool> isPermissionGranted() async {
    final status = await Geolocator.checkPermission();
    final isGranted = status == LocationPermission.always ||
      status == LocationPermission.whileInUse;
    return isGranted;
  }

  @override
  Future<LocationPermissionStatus> requestPermission() async {
    final status = await Geolocator.requestPermission();
    LocationPermissionStatus result = LocationPermissionStatus.granted;
    if (status == LocationPermission.deniedForever) {
      result = LocationPermissionStatus.deniedForever;
    } else if (status == LocationPermission.denied ||
      status == LocationPermission.unableToDetermine) {
      result = LocationPermissionStatus.denied;
    }
    return result;
  }
}