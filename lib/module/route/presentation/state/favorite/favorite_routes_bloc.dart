import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/module/route/domain/entity/route.dart';
import 'package:moreway/module/route/domain/interactor/route_interactor.dart';

part 'favorite_routes_event.dart';
part 'favorite_routes_state.dart';

class FavoriteRoutesBloc
    extends Bloc<FavoriteRoutesEvent, FavoriteRoutesState> {
  final RouteInteractor _routeInteractor;

  FavoriteRoutesBloc(this._routeInteractor) : super(FavoriteRoutesState()) {
    on<LoadFavoriteRoutesEvent>(_load);
    on<LoadMoreFavoriteRoutesEvent>(_loadMore);
    on<RemoveFavoriteRouteEvent>(_removeFavorite);
  }

  void _load(
      LoadFavoriteRoutesEvent event, Emitter<FavoriteRoutesState> emit) async {
    emit(state.resetData());
    try {
      final routePage = await _routeInteractor.getFavoriteRoutes();
      emit(state.copyWith(
          status: LoadingStatus.success,
          routes: () => routePage.items,
          cursor: routePage.cursor,
          hasReachedMax: routePage.cursor == null));
    } catch (e) {
      emit(state.copyWith(status: LoadingStatus.failure));
    }
  }

  void _loadMore(LoadMoreFavoriteRoutesEvent event,
      Emitter<FavoriteRoutesState> emit) async {
    if (state.hasReachedMax) return;
    emit(state.copyWith(status: LoadingStatus.initial));
    try {
      final routePage =
          await _routeInteractor.getFavoriteRoutes(cursor: state.cursor);
      emit(state.copyWith(
          status: LoadingStatus.success,
          routes: () => state.routes! + routePage.items,
          cursor: routePage.cursor,
          hasReachedMax: routePage.cursor == null));
    } catch (e) {
      emit(state.copyWith(status: LoadingStatus.failure));
    }
  }

  void _removeFavorite(
      RemoveFavoriteRouteEvent event, Emitter<FavoriteRoutesState> emit) async {
    try {
      await _routeInteractor.removeToFavorite(event.id);
      emit(state.copyWith(
        removeStatus: LoadingStatus.success,
        routes: () =>
            state.routes!..removeWhere((route) => route.id == event.id),
      ));
    } catch (e) {
      emit(state.copyWith(removeStatus: LoadingStatus.failure));
    }
  }
}
