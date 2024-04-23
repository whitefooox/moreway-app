import 'package:injectable/injectable.dart';
import 'package:moreway/module/location/domain/dependency/i_location_permission_service.dart';
import 'package:moreway/module/location/domain/dependency/i_location_service.dart';
import 'package:moreway/module/location/domain/entity/position.dart';
import 'package:moreway/module/location/domain/exception/no_location_permission.dart';

@Singleton()
class GetLocationStreamUsecase {
  final ILocationService _locationService;
  final ILocationPermissionService _permissionService;

  GetLocationStreamUsecase(this._locationService, this._permissionService);

  Future<Stream<Position>> execute() async {
    final isGranted = await _permissionService.isPermissionGranted();
    if (!isGranted) return Future.error(NoLocationPermissionException());
    return _locationService.getLocationStream();
  }
}
