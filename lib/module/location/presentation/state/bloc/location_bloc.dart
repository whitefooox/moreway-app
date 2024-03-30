import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:moreway/module/location/domain/entity/position.dart';
import 'package:moreway/module/location/domain/usecase/get_current_city.dart';

part 'location_event.dart';
part 'location_state.dart';

@Singleton()
class LocationBloc extends Bloc<LocationEvent, LocationState> {

  final GetCurrentCityUseCase _getCurrentCityUseCase;

  LocationBloc(
    this._getCurrentCityUseCase
  ) : super(LocationState()) {
    on<GetCurrentLocationEvent>(_getCity);
    super.add(GetCurrentLocationEvent());
  }

  void _getCity(
    GetCurrentLocationEvent event, 
    Emitter<LocationState> emit
  ) async {
    try {
      final city = await _getCurrentCityUseCase.execute();
      emit(state.copyWith(city: city, locationStatus: LocationStatus.success));
    } catch (e) {
      //emit(state.copyWith(loadingStatus: LoadingStatus.failure));
    }
  }
}
