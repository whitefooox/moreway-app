import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/module/place/domain/entity/place.dart';
import 'package:moreway/module/place/domain/entity/place_filters.dart';
import 'package:moreway/module/place/domain/usecase/get_places.dart';

part 'places_event.dart';
part 'places_state.dart';

@Injectable()
class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  final GetPlacesUseCase _getPlacesUseCase;

  PlacesBloc(this._getPlacesUseCase) : super(PlacesState()) {
    on<LoadPlacesEvent>(_load);
    on<SearchPlacesEvent>(_search);
    super.add(LoadPlacesEvent());
  }

  void _load(LoadPlacesEvent event, Emitter<PlacesState> emit) async {
    if (state.isAllLoaded) return;
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    try {
      final placePage = await _getPlacesUseCase.execute(
          cursor: state.cursor, filters: state.filters);
      emit(state.copyWith(
          loadingStatus: LoadingStatus.success,
          places: state.places + placePage.places,
          cursor: placePage.cursor,
          isAllLoaded: placePage.cursor == null));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(loadingStatus: LoadingStatus.failure));
    }
  }

  void _search(SearchPlacesEvent event, Emitter<PlacesState> emit) async {
    if (state.filters.search == event.query) return;
    emit(state
        .resetData()
        .copyWith(filters: state.filters.copyWith(search: event.query)));
    try {
      final placePage = await _getPlacesUseCase.execute(
          cursor: state.cursor, filters: state.filters);
      emit(state.copyWith(
          loadingStatus: LoadingStatus.success,
          places: state.places + placePage.places,
          cursor: placePage.cursor,
          isAllLoaded: placePage.cursor == null));
      log(state.places.toString());
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(loadingStatus: LoadingStatus.failure));
    }
  }
}
