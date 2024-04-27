import 'package:injectable/injectable.dart';
import 'package:moreway/module/location/domain/dependency/i_location_permission_service.dart';
import 'package:moreway/module/location/domain/dependency/i_location_service.dart';
import 'package:moreway/module/location/domain/entity/position.dart';
import 'package:moreway/module/location/domain/exception/no_location_permission.dart';

@Singleton()
class GetCurrentPositionUseCase {
  final ILocationPermissionService _permissionService;
  final ILocationService _locationService;

  GetCurrentPositionUseCase(this._permissionService, this._locationService);

  Future<Position> execute() async {
    final isGranted = await _permissionService.isPermissionGranted();
    if (!isGranted) return Future.error(NoLocationPermissionException());
    return _locationService.getCurrentPosition();
  }
}
