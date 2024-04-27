import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/module/place/domain/entity/place.dart';
import 'package:moreway/module/place/domain/entity/place_filter_options.dart';
import 'package:moreway/module/place/domain/entity/selected_place_filters.dart';
import 'package:moreway/module/place/domain/usecase/get_filters.dart';
import 'package:moreway/module/place/domain/usecase/get_places.dart';

part 'places_event.dart';
part 'places_state.dart';

@Injectable()
class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  final GetPlacesUseCase _getPlacesUseCase;
  final GetFiltersUsecase _getFiltersUsecase;

  PlacesBloc(this._getPlacesUseCase, this._getFiltersUsecase)
      : super(PlacesState()) {
    on<LoadPlacesEvent>(_load);
    on<SearchPlacesEvent>(_search);
    on<LoadPlacesAndFiltersEvent>(_loadPlacesAndFilters);
    on<UpdateFiltersEvent>(_updateFilters);
    //super.add(LoadPlacesAndFiltersEvent());
  }

  void _load(LoadPlacesEvent event, Emitter<PlacesState> emit) async {
    if (state.isAllLoaded) return;
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    try {
      final placePage = await _getPlacesUseCase.execute(
          cursor: state.cursor, filters: state.filters);
      emit(state.copyWith(
          loadingStatus: LoadingStatus.success,
          places: state.places! + placePage.places,
          cursor: placePage.cursor,
          isAllLoaded: placePage.cursor == null));
    } catch (e) {
      emit(state.copyWith(loadingStatus: LoadingStatus.failure));
    }
  }

  void _search(SearchPlacesEvent event, Emitter<PlacesState> emit) async {
    if (state.filters!.search == event.query) return;
    emit(state
        .resetData()
        .copyWith(filters: state.filters!..search = event.query));
    try {
      final placePage = await _getPlacesUseCase.execute(
          cursor: state.cursor, filters: state.filters);
      emit(state.copyWith(
          loadingStatus: LoadingStatus.success,
          places: placePage.places,
          cursor: placePage.cursor,
          isAllLoaded: placePage.cursor == null));
    } catch (e) {
      emit(state.copyWith(loadingStatus: LoadingStatus.failure));
    }
  }

  void _loadPlacesAndFilters(
      LoadPlacesAndFiltersEvent event, Emitter<PlacesState> emit) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    try {
      final placePage = await _getPlacesUseCase.execute();
      final placeFilters = await _getFiltersUsecase.execute();
      emit(state.copyWith(
          loadingStatus: LoadingStatus.success,
          places: placePage.places,
          cursor: placePage.cursor,
          isAllLoaded: placePage.cursor == null,
          filterOptions: placeFilters,
          filters: SelectedPlaceFilters(
              rangeRating: placeFilters.rangeRating,
              distance: placeFilters.rangeDistance)));
    } catch (e) {
      emit(state.copyWith(loadingStatus: LoadingStatus.failure));
    }
  }

  void _updateFilters(
      UpdateFiltersEvent event, Emitter<PlacesState> emit) async {
    emit(state.copyWith(filters: event.filters));
    emit(state.resetData());
    try {
      final placePage = await _getPlacesUseCase.execute(
          cursor: state.cursor, filters: state.filters);
      emit(state.copyWith(
          loadingStatus: LoadingStatus.success,
          places: placePage.places,
          cursor: placePage.cursor,
          isAllLoaded: placePage.cursor == null));
    } catch (e) {
      emit(state.copyWith(loadingStatus: LoadingStatus.failure));
    }
  }
}
