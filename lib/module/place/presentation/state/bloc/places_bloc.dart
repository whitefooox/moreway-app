import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/module/place/domain/entity/place.dart';
import 'package:moreway/module/place/domain/usecase/get_places.dart';

part 'places_event.dart';
part 'places_state.dart';

@Injectable()
class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {

  final GetPlacesUseCase _getPlacesUseCase;

  PlacesBloc(
    this._getPlacesUseCase
  ) : super(PlacesState()) {
    on<LoadPlacesEvent>(_load);
    super.add(LoadPlacesEvent());
  }

  void _load(
    LoadPlacesEvent event, 
    Emitter<PlacesState> emit
  ) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    try {
      final places = await _getPlacesUseCase.execute();
      emit(state.copyWith(loadingStatus: LoadingStatus.success, places: places));
    } catch (e) {
      emit(state.copyWith(loadingStatus: LoadingStatus.failure));
    }
  }
}
