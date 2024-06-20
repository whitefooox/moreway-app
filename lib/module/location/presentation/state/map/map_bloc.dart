import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/module/location/domain/entity/position.dart';
import 'package:moreway/module/location/domain/entity/position_point.dart';
import 'package:moreway/module/location/domain/entity/route_info.dart';
import 'package:moreway/module/location/domain/usecase/get_location_stream.dart';
import 'package:moreway/module/location/domain/usecase/navigation_interactor.dart';
import 'package:moreway/module/place/domain/entity/place_base.dart';
import 'package:moreway/module/route/domain/entity/route_detailed.dart';
import 'package:moreway/module/route/domain/interactor/active_route_interactor.dart';
import 'dart:math' show cos, sqrt, asin, sin;

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
    on<_CreateRouteEvent>(_createRoute);
    on<PassPointMapEvent>(_passPoint);
  }

  PlaceBase? _getTargetPlace(RouteDetailed route) {
    for (var point in route.points) {
      if (point.isCompleted == false) {
        return point.place;
      }
    }
    return null;
  }

  void _createRoute(_CreateRouteEvent event, Emitter<MapState> emit) async {
    if (state.targetPlace == null || state.position == null) return;
    emit(state.copyWith(routeInfoStatus: LoadingStatus.loading));
    final placePositionPoint = PositionPoint(
        latitude: state.targetPlace!.lat, longitude: state.targetPlace!.lon);
    try {
      final routeInfo = await _navigationInteractor
          .getRoute([state.position!.point, placePositionPoint]);
      emit(state.copyWith(
          routeInfo: routeInfo, routeInfoStatus: LoadingStatus.success));
    } catch (e) {
      emit(state.copyWith(routeInfoStatus: LoadingStatus.failure));
    }
  }

  void _reset(ResetMapEvent event, Emitter<MapState> emit) {
    emit(MapState());
  }

  void _load(LoadActiveRouteEvent event, Emitter<MapState> emit) async {
    emit(state.copyWith(activeRoutestatus: LoadingStatus.loading));
    try {
      final activeRoute = await _activeRouteInteractor.getActiveRoute();
      emit(state.copyWith(
          activeRoute: activeRoute,
          activeRoutestatus: LoadingStatus.success,
          targetPlace: _getTargetPlace(activeRoute!)));
    } catch (e) {
      emit(state.copyWith(activeRoutestatus: LoadingStatus.failure));
    }
    add(_CreateRouteEvent());
  }

  void _setActiveRoute(
      SetActiveRouteEvent event, Emitter<MapState> emit) async {
    emit(state.copyWith(replaceStatus: LoadingStatus.loading));
    try {
      final activeRoute =
          await _activeRouteInteractor.setActiveRoute(event.routeId);
      emit(state.copyWith(
          activeRoute: activeRoute,
          activeRoutestatus: LoadingStatus.success,
          replaceStatus: LoadingStatus.success,
          targetPlace: _getTargetPlace(activeRoute)));
    } catch (e) {
      emit(state.copyWith(replaceStatus: LoadingStatus.failure));
    }
    add(_CreateRouteEvent());
  }

  void _subscribeToPositions(
      SubscribeToPositionsEvent event, Emitter<MapState> emit) async {
    emit(state.copyWith(positionStatus: LoadingStatus.loading));
    try {
      final locationStream = await _getLocationStreamUsecase.execute();
      await emit.onEach(locationStream, onData: (position) {
        emit(state.copyWith(
            positionStatus: LoadingStatus.success, position: position));
        //add(_CreateRouteEvent());
        if (state.targetPlace != null && state.position != null) {
          emit(state.copyWith(
              distanceToTargetPlace: position.point.distanceTo(PositionPoint(
                  latitude: state.targetPlace!.lat,
                  longitude: state.targetPlace!.lon))));
        }
      }, onError: (error, stackTrace) {
        emit(state.copyWith(positionStatus: LoadingStatus.failure));
      });
    } catch (e) {
      emit(state.copyWith(positionStatus: LoadingStatus.failure));
    }
  }

  void _passPoint(PassPointMapEvent event, Emitter<MapState> emit) async {
    emit(state.copyWith(passPointStatus: LoadingStatus.loading));
    try {
      _activeRouteInteractor.completePoint(state.targetPlace!.id);
      emit(state.copyWith(passPointStatus: LoadingStatus.success));
      final targetPlace = _getTargetPlace(state.activeRoute!);
      if (targetPlace == null) {
      } else {
        emit(state.copyWith(targetPlace: targetPlace));
      }
    } catch (e) {
      emit(state.copyWith(passPointStatus: LoadingStatus.failure));
    }
  }
}
