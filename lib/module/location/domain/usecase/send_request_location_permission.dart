import 'package:moreway/module/location/domain/dependency/i_location_permission_service.dart';
import 'package:moreway/module/location/domain/entity/location_permission_status.dart';

class SendRequestLocationPermissionUseCase {
  final ILocationPermissionService _locationPermissionService;

  SendRequestLocationPermissionUseCase(this._locationPermissionService);

  Future<LocationPermissionStatus> execute() {
    return _locationPermissionService.requestPermission();
  }
}
