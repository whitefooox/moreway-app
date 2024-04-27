import 'package:injectable/injectable.dart';
import 'package:moreway/module/location/domain/dependency/i_geoincoder_service.dart';
import 'package:moreway/module/location/domain/dependency/i_location_permission_service.dart';
import 'package:moreway/module/location/domain/dependency/i_location_service.dart';
import 'package:moreway/module/location/domain/exception/no_location_permission.dart';

@Singleton()
class GetCurrentCityUseCase {
  final IGeoincoderService _geoincoderService;
  final ILocationPermissionService _locationPermissionService;
  final ILocationService _locationService;

  GetCurrentCityUseCase(this._geoincoderService,
      this._locationPermissionService, this._locationService);

  Future<String> execute() async {
    final isGranted = await _locationPermissionService.isPermissionGranted();
    if (!isGranted) return Future.error(NoLocationPermissionException());
    final position = await _locationService.getCurrentPosition();
    return _geoincoderService.getCity(position.point);
  }
}
