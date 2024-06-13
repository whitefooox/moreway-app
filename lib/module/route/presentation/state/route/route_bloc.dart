import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/module/location/domain/entity/position_point.dart';
import 'package:moreway/module/location/domain/usecase/navigation_interactor.dart';
import 'package:moreway/module/location/presentation/state/map/map_bloc.dart';
import 'package:moreway/module/route/domain/entity/route_detailed.dart';
import 'package:moreway/module/route/domain/interactor/active_route_interactor.dart';
import 'package:moreway/module/route/domain/interactor/route_interactor.dart';

part 'route_event.dart';
part 'route_state.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  final RouteInteractor _routeInteractor;
  final NavigationInteractor _navigationInteractor;
  final ActiveRouteInteractor _activeRouteInteractor;
  final MapBloc _mapBloc;

  RouteBloc(this._routeInteractor, this._navigationInteractor, this._mapBloc, this._activeRouteInteractor)
      : super(RouteState()) {
    on<RouteLoadEvent>(_load);
    on<LikeRouteEvent>(_like);
    on<UnlikeRouteEvent>(_unlike);
    on<ActiveSetRouteEvent>(_setActive);
  }

  void _setActive(ActiveSetRouteEvent event, Emitter<RouteState> emit) async {
    emit(state.copyWith(route: state.route!.copyWith(isActive: true)));
  }

  void _load(RouteLoadEvent event, Emitter<RouteState> emit) async {
    emit(state.copyWith(routeId: event.id));
    await _loadRouteDetailed(emit);
    await _loadRouteCoordinates(emit);
  }

  void _like(LikeRouteEvent event, Emitter<RouteState> emit) async {
    try {
      await _routeInteractor.addToFavorite(state.routeId!);
      emit(state.copyWith(route: state.route!.copyWith(isFavorite: true)));
    } catch (e) {}
  }

  void _unlike(UnlikeRouteEvent event, Emitter<RouteState> emit) async {
    try {
      await _routeInteractor.removeToFavorite(state.routeId!);
      emit(state.copyWith(route: state.route!.copyWith(isFavorite: false)));
    } catch (e) {}
  }

  Future<void> _loadRouteDetailed(Emitter<RouteState> emit) async {
    emit(state.copyWith(routeDetailedStatus: LoadingStatus.loading));
    try {
      final place = await _routeInteractor.getRouteDetailed(state.routeId!);
      emit(state.copyWith(
          routeDetailedStatus: LoadingStatus.success, route: place));
    } catch (e) {
      emit(state.copyWith(routeDetailedStatus: LoadingStatus.failure));
    }
  }

  Future<void> _loadRouteCoordinates(Emitter<RouteState> emit) async {
    emit(state.copyWith(routeCoordinatesStatus: LoadingStatus.loading));
    try {
      final routeInfo = await _navigationInteractor.getRoute(state
          .route!.points
          .map((e) =>
              PositionPoint(latitude: e.place.lat, longitude: e.place.lon))
          .toList());
      emit(state.copyWith(
          routeCoordinatesStatus: LoadingStatus.success,
          routeCoordinates: routeInfo.points));
    } catch (e) {
      emit(state.copyWith(routeCoordinatesStatus: LoadingStatus.failure));
    }
  }
}
