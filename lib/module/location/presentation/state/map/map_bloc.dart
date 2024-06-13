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
  }

  double _toRadians(double degrees) {
    return degrees * (3.1415926535897932 / 180);
  }

  double _calculateDistance(PositionPoint point1, PositionPoint point2) {
    const double earthRadius = 6371; // Радиус Земли в километрах

    double lat1 = _toRadians(point1.latitude);
    double lon1 = _toRadians(point1.longitude);
    double lat2 = _toRadians(point2.latitude);
    double lon2 = _toRadians(point2.longitude);

    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;

    double a = asin(sqrt(sin(dLat / 2) * sin(dLat / 2) +
            cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2))) *
        2;

    return earthRadius * a;
  }

  PlaceBase? _getTargetPlace(RouteDetailed route) {
    for (var point in route.points) {
      if (point.isCompleted == false) {
        return point.place;
      }
    }
    return null;
  }

  int _getCurrentProgress(RouteDetailed route) {
    return route.points
        .where((element) => element.isCompleted == true)
        .toList()
        .length;
  }

  int _getMaxProgress(RouteDetailed route) {
    return route.points.length;
  }

  void _createRoute(_CreateRouteEvent event, Emitter<MapState> emit) async {
    if (state.targetPlace == null || state.position == null) return;
    final placePositionPoint = PositionPoint(
        latitude: state.targetPlace!.lat, longitude: state.targetPlace!.lon);
    try {
      final routeInfo = await _navigationInteractor
          .getRoute([state.position!.point, placePositionPoint]);
      emit(state.copyWith(
        routeInfo: routeInfo,
      ));
    } catch (e) {
      //emit(state.copyWith(activeRoutestatus: LoadingStatus.failure));
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
        add(_CreateRouteEvent());
      }, onError: (error, stackTrace) {
        emit(state.copyWith(positionStatus: LoadingStatus.failure));
      });
    } catch (e) {
      emit(state.copyWith(positionStatus: LoadingStatus.failure));
    }
  }
}
