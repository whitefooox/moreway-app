import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/core/square_widget.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:moreway/module/location/domain/entity/position.dart';
import 'package:moreway/module/location/domain/entity/route_info.dart';
import 'package:moreway/module/location/presentation/widget/point_passed_popup.dart';
import 'package:moreway/module/location/presentation/widget/route_progree_bar.dart';
import 'package:moreway/module/place/domain/entity/place_base.dart';
import 'package:moreway/module/location/presentation/state/map/map_bloc.dart';
import 'package:moreway/module/route/domain/entity/route_detailed.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();
  late final MapBloc _mapBloc;

  @override
  void initState() {
    super.initState();
    _mapBloc = BlocProvider.of<MapBloc>(context);
  }

  Widget _buildCompleteButton() {
    return IconButton(
      onPressed: () => _mapBloc.add(PassPointMapEvent()),
      icon: const CircleAvatar(
        radius: 25,
        backgroundColor: AppColor.black,
        child: Icon(
          Icons.flag,
          color: AppColor.white,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildRouteCard(RouteDetailed? activeRoute,
      LoadingStatus activeRouteStatus, TextTheme textTheme) {
    switch (activeRouteStatus) {
      case LoadingStatus.success:
        return Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  activeRoute != null
                      ? activeRoute.name
                      : "Нет активного маршрута",
                  style: textTheme.titleLarge!.copyWith(
                    color: AppColor.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (activeRoute != null) ...[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: RouteProgressBar(
                      currentProgress: activeRoute.points
                          .where((element) => element.isCompleted! == true)
                          .toList()
                          .length,
                      maxProgress: activeRoute.points.length,
                    ),
                  )
                ]
              ],
            ),
          ),
        );
      case LoadingStatus.failure:
        return Placeholder();
      default:
        return Placeholder();
    }
  }

  Widget _buildPositionButton(
      LoadingStatus positionStatus, Position? position) {
    switch (positionStatus) {
      case LoadingStatus.success:
        return IconButton(
          onPressed: () {
            if (position == null) return;
            _mapController.move(
              LatLng(position.point.latitude, position.point.longitude),
              15.0,
            );
          },
          icon: const CircleAvatar(
            radius: 25,
            backgroundColor: AppColor.black,
            child: Icon(
              Icons.my_location,
              color: AppColor.white,
              size: 20,
            ),
          ),
        );
      case LoadingStatus.failure:
        return IconButton(
          onPressed: () {},
          icon: const CircleAvatar(
            radius: 25,
            backgroundColor: AppColor.black,
            child: Icon(
              Icons.warning,
              color: AppColor.white,
              size: 20,
            ),
          ),
        );
      default:
        return IconButton(
          onPressed: () {},
          icon: const CircleAvatar(
            radius: 25,
            backgroundColor: AppColor.black,
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: AppColor.white,
              ),
            ),
          ),
        );
    }
  }

  Marker _buildCurrentPositionMarker(Position position) {
    final point = LatLng(position.point.latitude, position.point.longitude);
    return Marker(
        width: 30,
        height: 30,
        point: point,
        child: Transform.rotate(
          angle: position.heading,
          child: const CircleAvatar(
            radius: 15,
            backgroundColor: AppColor.pink,
            child: Icon(
              Icons.navigation,
              color: AppColor.white,
              size: 15,
            ),
          ),
        ));
  }

  Widget _buildMap(
      Position? position, PlaceBase? targetPlace, RouteInfo? routeInfo) {
    return FlutterMap(
        mapController: _mapController,
        options: const MapOptions(
            zoom: 15,
            initialCenter:
                //LatLng(position.point.latitude, position.point.longitude),
                LatLng(55.3333, 86.0833)),
        children: [
          TileLayer(
            urlTemplate:
                'https://api.maptiler.com/maps/dataviz/256/{z}/{x}/{y}.png?key=U7c9AKtTUegJLtvD7NKg',
          ),
          PolylineLayer(
            polylines: routeInfo != null
                ? [
                    Polyline(
                      points: routeInfo.points
                          .map((e) => LatLng(e.latitude, e.longitude))
                          .toList(),
                      strokeWidth: 4.0,
                      color: AppColor.pink,
                    ),
                  ]
                : [],
          ),
          MarkerLayer(markers: [
            if (position != null) ...[
              _buildCurrentPositionMarker(position),
            ],
            if (targetPlace != null) ...[
              Marker(
                width: 30,
                height: 30,
                point: LatLng(targetPlace.lat, targetPlace.lon),
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: AppColor.pink.withOpacity(0.5),
                  child: CircleAvatar(
                    backgroundColor: AppColor.pink,
                    radius: 8,
                  ),
                ),
              )
            ]
          ]),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final screenSize = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: BlocListener<MapBloc, MapState>(
        listenWhen: (previous, current) {
          if (previous.passPointStatus != current.passPointStatus) {
            return true;
          } else {
            return false;
          }
        },
        listener: (context, state) {
          if (state.passPointStatus == LoadingStatus.failure) {
            showDialog(
              context: context,
              builder: (context) => const PointPassedPopup(),
            );
          }
        },
        child: BlocBuilder<MapBloc, MapState>(
            bloc: mapBloc,
            builder: (context, state) {
              //log(state.positionStatus.name.toString());
              return Stack(
                children: [
                  _buildMap(state.position, state.targetPlace, state.routeInfo),
                  // Positioned(
                  //     bottom: screenSize.width * 0.035 + 60 + 10,
                  //     right: screenSize.width * 0.035,
                  //     //           left: screenSize.width * 0.035,
                  //     child: _buildPositionButton(
                  //         state.positionStatus, state.position)),
                  Positioned(
                      top: screenSize.width * 0.035,
                      left: screenSize.width * 0.035,
                      right: screenSize.width * 0.035,
                      child: _buildRouteCard(state.activeRoute,
                          state.activeRoutestatus, textTheme)),
                  Positioned(
                    left: screenSize.width * 0.035,
                    right: screenSize.width * 0.035,
                    bottom: screenSize.width * 0.035 + 60 + 10,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (state.targetPlace != null && state.distanceToTargetPlace != null) ...[
                          Expanded(
                            child: Container(
                              height: 100,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: AppColor.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    SquareWidget(
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            child: Image.network(
                                                fit: BoxFit.fill,
                                                state.targetPlace!.image))),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          state.targetPlace!.name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                              TextStyle(fontFamily: "roboto"),
                                        ),
                                        Text("~${state.distanceToTargetPlace!.toStringAsFixed(2)} км.")
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                        SizedBox(
                          width: 10,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildPositionButton(
                                state.positionStatus, state.position),
                            _buildCompleteButton()
                          ],
                        )
                      ],
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}


