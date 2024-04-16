import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:moreway/module/location/domain/entity/position.dart';
import 'package:moreway/module/location/domain/usecase/get_current_city.dart';
import 'package:moreway/module/location/domain/usecase/get_current_location.dart';

part 'location_event.dart';
part 'location_state.dart';

@Singleton()
class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetCurrentCityUseCase _getCurrentCityUseCase;
  final GetCurrentPositionUseCase _getCurrentPositionUseCase;

  LocationBloc(this._getCurrentCityUseCase, this._getCurrentPositionUseCase)
      : super(LocationState()) {
    on<GetCurrentLocationEvent>(_getCity);
    super.add(GetCurrentLocationEvent());
  }

  void _getCity(
      GetCurrentLocationEvent event, Emitter<LocationState> emit) async {
    try {
      final city = await _getCurrentCityUseCase.execute();
      final position = await _getCurrentPositionUseCase.execute();
      emit(state.copyWith(
          city: city,
          locationStatus: LocationStatus.success,
          currentPosition: position));
    } catch (e) {
      //emit(state.copyWith(loadingStatus: LoadingStatus.failure));
    }
  }
}
