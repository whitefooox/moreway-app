import 'dart:developer';

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
    on<UpdateAllRouteBuilderEvent>(_updateAll);
    on<CreateRouteBuilderEvent>(_createRoute);
  }

  List<String> _getPlaceIndexes() {
    return state.route!.toPlacesId();
  }

  void _createRoute(
      CreateRouteBuilderEvent event, Emitter<RouteBuilderState> emit) async {
    emit(state.copyWith(
        operationStatus: RouteBuilderOperationStatus.loadingCreating));
    try {
      final route =
          await _routeBuilderInteractor.build(event.name);
      emit(state.createdState());
    } catch (e) {
      emit(state.copyWith(
          operationStatus: RouteBuilderOperationStatus.errorCreating,
          errorMessage: "Не удалось создать маршрут"));
    }
  }

  void _updateAll(
      UpdateAllRouteBuilderEvent event, Emitter<RouteBuilderState> emit) async {
    emit(state.copyWith(
        operationStatus: RouteBuilderOperationStatus.loadingUpdating));
    try {
      final routeRaw =
          await _routeBuilderInteractor.editRoute(event.route.toPlacesId());
      emit(state.copyWith(
          route: routeRaw,
          operationStatus: RouteBuilderOperationStatus.updated));
    } catch (e) {
      emit(state.copyWith(
          operationStatus: RouteBuilderOperationStatus.errorUpdating,
          errorMessage: "Не удалось обновить"));
    }
  }

  void _addPlace(
      AddPlaceRouteBuilderEvent event, Emitter<RouteBuilderState> emit) async {
    if (state.placesCount == 15) {
      emit(state.copyWith(
          operationStatus: RouteBuilderOperationStatus.errorAdding,
          errorMessage: "Конструктор переполнен"));
      return;
    }
    emit(state.copyWith(operationStatus: RouteBuilderOperationStatus.loading));
    try {
      final routeRaw = await _routeBuilderInteractor
          .editRoute(_getPlaceIndexes()..add(event.placeId));
      emit(state.copyWith(
          route: routeRaw, operationStatus: RouteBuilderOperationStatus.added));
    } catch (e) {
      emit(state.copyWith(
          operationStatus: RouteBuilderOperationStatus.errorAdding,
          errorMessage: "Не удалось добавить"));
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
          operationStatus: RouteBuilderOperationStatus.errorRemoving,
          errorMessage: "Не удалось удалить"));
    }
  }

  void _loadBuilder(
      LoadRouteBuilderEvent event, Emitter<RouteBuilderState> emit) async {
    emit(state.copyWith(routeStatus: LoadingStatus.loading));
    try {
      final route = await _routeBuilderInteractor.getRoute();
      emit(state.copyWith(route: route, routeStatus: LoadingStatus.success));
    } catch (e) {
      emit(state.copyWith(
          routeStatus: LoadingStatus.failure,
          errorMessage: "Не удалось загрузить конструктор"));
    }
  }
}
