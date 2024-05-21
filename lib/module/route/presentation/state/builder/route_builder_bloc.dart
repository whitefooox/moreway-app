import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/module/route/domain/entity/route_raw.dart';
import 'package:moreway/module/route/domain/interactor/route_builder_interactor.dart';

part 'route_builder_event.dart';
part 'route_builder_state.dart';

class RouteBuilderBloc extends Bloc<RouteBuilderEvent, RouteBuilderState> {
  final RouteBuilderInteractor _routeBuilderInteractor;

  RouteBuilderBloc(this._routeBuilderInteractor) : super(RouteBuilderState()) {
    on<LoadRouteBuilderEvent>(_loadBuilder);
    on<AddPlaceRouteBuilderEvent>(_addPlace);
    on<RemovePlaceRouteBuilderEvent>(_removePlace);
  }

  List<String> _getPlaceIndexes() {
    return state.route!.points.map((place) => place.id).toList();
  }

  void _addPlace(
      AddPlaceRouteBuilderEvent event, Emitter<RouteBuilderState> emit) async {
    emit(state.copyWith(operationStatus: RouteBuilderOperationStatus.loading));
    try {
      final routeRaw = await _routeBuilderInteractor
          .editRoute(_getPlaceIndexes()..add(event.placeId));
      emit(state.copyWith(
          route: routeRaw, operationStatus: RouteBuilderOperationStatus.added));
    } catch (e) {
      emit(state.copyWith(
          operationStatus: RouteBuilderOperationStatus.errorAdding));
    }
  }

  void _removePlace(RemovePlaceRouteBuilderEvent event,
      Emitter<RouteBuilderState> emit) async {
    emit(state.copyWith(operationStatus: RouteBuilderOperationStatus.loading));
    try {
      final routeRaw = await _routeBuilderInteractor
          .editRoute(_getPlaceIndexes()..remove(event.placeId));
      emit(state.copyWith(
          route: routeRaw,
          operationStatus: RouteBuilderOperationStatus.removed));
    } catch (e) {
      emit(state.copyWith(
          operationStatus: RouteBuilderOperationStatus.errorRemoving));
    }
  }

  void _loadBuilder(
      LoadRouteBuilderEvent event, Emitter<RouteBuilderState> emit) async {
    emit(state.copyWith(routeStatus: LoadingStatus.loading));
    try {
      final route = await _routeBuilderInteractor.getRoute();
      emit(state.copyWith(route: route, routeStatus: LoadingStatus.success));
    } catch (e) {
      emit(state.copyWith(routeStatus: LoadingStatus.failure));
    }
  }
}
