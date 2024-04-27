
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moreway/module/location/domain/entity/position.dart';
import 'package:moreway/module/location/domain/usecase/get_location_stream.dart';

part 'location_v2_event.dart';
part 'location_v2_state.dart';

class LocationV2Bloc extends Bloc<LocationV2Event, LocationV2State> {
  final GetLocationStreamUsecase _getLocationStreamUsecase;

  LocationV2Bloc(this._getLocationStreamUsecase) : super(LocationV2Loading()) {
    on<LocationV2EventLoad>(_load);
  }

  void _load(LocationV2EventLoad event, Emitter<LocationV2State> emit) async {
    try {
      final locationStream = await _getLocationStreamUsecase.execute();
      await emit.forEach(locationStream,
          onData: (position) => LocationV2Loaded(location: position),
          onError: (error, stackTrace) => LocationV2Failure());
    } catch (e) {
      emit(LocationV2Failure());
    }
  }

}
