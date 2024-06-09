import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/module/location/domain/entity/position.dart';
import 'package:moreway/module/location/domain/usecase/get_location_stream.dart';
import 'package:moreway/module/location/domain/usecase/navigation_interactor.dart';
import 'package:moreway/module/route/domain/entity/route_detailed.dart';
import 'package:moreway/module/route/domain/interactor/active_route_interactor.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final ActiveRouteInteractor _activeRouteInteractor;
  final GetLocationStreamUsecase _getLocationStreamUsecase;
  final NavigationInteractor _navigationInteractor;

  MapBloc(this._activeRouteInteractor, this._getLocationStreamUsecase,
      this._navigationInteractor)
      : super(MapState()) {
    on<LoadActiveRouteEvent>(_load);
    on<SubscribeToPositionsEvent>(_subscribeToPositions);
    on<SetActiveRouteEvent>(_setActiveRoute);
    on<ResetMapEvent>(_reset);
  }

  void _reset(ResetMapEvent event, Emitter<MapState> emit){
    emit(MapState());
  }

  void _load(LoadActiveRouteEvent event, Emitter<MapState> emit) async {
    emit(state.copyWith(activeRoutestatus: LoadingStatus.loading));
    try {
      final activeRoute = await _activeRouteInteractor.getActiveRoute();
      emit(state.copyWith(
          activeRoute: activeRoute, activeRoutestatus: LoadingStatus.success));
    } catch (e) {
      emit(state.copyWith(activeRoutestatus: LoadingStatus.failure));
    }
  }

  void _setActiveRoute(SetActiveRouteEvent event, Emitter<MapState> emit) async {
    emit(state.copyWith(replaceStatus: LoadingStatus.loading));
    try {
      final activeRoute = await _activeRouteInteractor.setActiveRoute(event.routeId);
      emit(state.copyWith(
          activeRoute: activeRoute, replaceStatus: LoadingStatus.success));
    } catch (e) {
      emit(state.copyWith(replaceStatus: LoadingStatus.failure));
    }
  }

  void _subscribeToPositions(
      SubscribeToPositionsEvent event, Emitter<MapState> emit) async {
    emit(state.copyWith(positionStatus: LoadingStatus.loading));
    try {
      final locationStream = await _getLocationStreamUsecase.execute();
      await emit.forEach(locationStream,
          onData: (position) => state.copyWith(
              positionStatus: LoadingStatus.success, position: position),
          onError: (error, stackTrace) {
            return state.copyWith(positionStatus: LoadingStatus.failure);
          });
    } catch (e) {
      emit(state.copyWith(positionStatus: LoadingStatus.failure));
    }
  }
}
