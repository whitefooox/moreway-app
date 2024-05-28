import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moreway/module/place/domain/entity/place.dart';
import 'package:moreway/module/place/domain/entity/place_filter_options.dart';
import 'package:moreway/module/place/domain/entity/selected_place_filters.dart';
import 'package:moreway/module/place/domain/usecase/place_interactor.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  final PlaceInteractor _placeInteractor;

  PlacesBloc(this._placeInteractor)
      : super(PlacesState()) {
    on<LoadPlacesEvent>(_load);
    on<SearchPlacesEvent>(_search);
    on<LoadPlacesAndFiltersEvent>(_loadPlacesAndFilters);
    on<UpdateFiltersEvent>(_updateFilters);
    on<LoadMorePlacesEvent>(_loadMore);
    on<ResetFiltersEvent>(_resetFilters);
  }

  void _load(LoadPlacesEvent event, Emitter<PlacesState> emit) async {
    emit(state.resetData());
    emit(state.copyWith(status: PlacesStatus.loading));
    try {
      final placePage = await _placeInteractor.getPlaces(
          filters: state.filters);
      emit(state.copyWith(
          status: PlacesStatus.success,
          places: () => placePage.items,
          cursor: placePage.cursor,
          hasReachedMax: placePage.cursor == null));
    } catch (e) {
      emit(state.copyWith(status: PlacesStatus.failure));
    }
  }

  void _loadMore(LoadMorePlacesEvent event, Emitter<PlacesState> emit) async {
    if (state.hasReachedMax) return;
    emit(state.copyWith(status: PlacesStatus.loading));
    try {
      final placePage = await _placeInteractor.getPlaces(
          cursor: state.cursor, filters: state.filters);
      emit(state.copyWith(
          status: PlacesStatus.success,
          places: () => state.places! + placePage.items,
          cursor: placePage.cursor,
          hasReachedMax: placePage.cursor == null));
    } catch (e) {
      emit(state.copyWith(status: PlacesStatus.failure));
    }
  }

  void _search(SearchPlacesEvent event, Emitter<PlacesState> emit) async {
    if (state.filters.search == event.query) return;
    emit(state.resetData().copyWith(
        filters: state.filters.copyWithNull(search: () => event.query)));
    add(LoadPlacesEvent());
  }

  void _loadPlacesAndFilters(
      LoadPlacesAndFiltersEvent event, Emitter<PlacesState> emit) async {
    emit(state.copyWith(status: PlacesStatus.loading));
    try {
      final placePage = await _placeInteractor.getPlaces();
      final placeFilters = await _placeInteractor.getFilters();
      emit(state.copyWith(
          status: PlacesStatus.success,
          places: () => placePage.items,
          cursor: placePage.cursor,
          hasReachedMax: placePage.cursor == null,
          filterOptions: placeFilters));
    } catch (e) {
      emit(state.copyWith(status: PlacesStatus.failure));
    }
  }

  void _updateFilters(
      UpdateFiltersEvent event, Emitter<PlacesState> emit) async {
    emit(state.resetData().copyWith(filters: event.filters));
    add(LoadPlacesEvent());
  }

  void _resetFilters(ResetFiltersEvent event, Emitter<PlacesState> emit) async {
    emit(state.resetData().copyWith(filters: const SelectedPlaceFilters()));
    add(LoadPlacesEvent());
  }
}
