import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moreway/module/route/domain/entity/route.dart';
import 'package:moreway/module/route/domain/interactor/route_interactor.dart';

part 'routes_event.dart';
part 'routes_state.dart';

class RoutesBloc extends Bloc<RoutesEvent, RoutesState> {
  final RouteInteractor _routeInteractor;

  RoutesBloc(this._routeInteractor) : super(RoutesState()) {
    on<LoadRoutesEvent>(_load);
    on<LoadMoreRoutesEvent>(_loadMore);
  }

  void _load(LoadRoutesEvent event, Emitter<RoutesState> emit) async {
    emit(state.resetData());
    try {
      final routePage = await _routeInteractor.getRoutes(cursor: state.cursor);
      emit(state.copyWith(
          status: RoutesStatus.success,
          routes: () => routePage.items,
          cursor: routePage.cursor,
          hasReachedMax: routePage.cursor == null));
    } catch (e) {
      emit(state.copyWith(status: RoutesStatus.failure));
    }
  }

  void _loadMore(LoadMoreRoutesEvent event, Emitter<RoutesState> emit) async {
    log(state.hasReachedMax.toString());
    log("load more");
    if (state.hasReachedMax) return;
    emit(state.copyWith(status: RoutesStatus.initial));
    log("load loading");
    
    try {
      final routePage =
          await _routeInteractor.getRoutes(cursor: state.cursor);
      emit(state.copyWith(
          status: RoutesStatus.success,
          routes: () => state.routes! + routePage.items,
          cursor: routePage.cursor,
          hasReachedMax: routePage.cursor == null));
          log("load success");
    } catch (e) {
      emit(state.copyWith(status: RoutesStatus.failure));
      log("load failure");
    }
  }
}
