import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/module/route/domain/entity/route.dart';
import 'package:moreway/module/route/domain/interactor/route_interactor.dart';

part 'created_routes_event.dart';
part 'created_routes_state.dart';

class CreatedRoutesBloc extends Bloc<CreatedRoutesEvent, CreatedRoutesState> {
  final RouteInteractor _routeInteractor;

  CreatedRoutesBloc(this._routeInteractor) : super(CreatedRoutesState()) {
    on<LoadCreatedRoutesEvent>(_load);
    on<LoadMoreCreatedRoutesEvent>(_loadMore);
  }

  void _load(
      LoadCreatedRoutesEvent event, Emitter<CreatedRoutesState> emit) async {
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

  void _loadMore(LoadMoreCreatedRoutesEvent event,
      Emitter<CreatedRoutesState> emit) async {
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
}
