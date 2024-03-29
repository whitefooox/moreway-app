import 'package:moreway/module/permission/domain/entity/location_permission_status.dart';

abstract class ILocationPermissionService {
  Future<LocationPermissionStatus> requestPermission();
  Future<bool> isPermissionGranted();
}