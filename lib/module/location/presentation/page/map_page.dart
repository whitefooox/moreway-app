import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/core/square_widget.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:moreway/module/location/domain/entity/position.dart';
import 'package:moreway/module/location/domain/entity/position_point.dart';
import 'package:moreway/module/location/domain/usecase/navigation_interactor.dart';
import 'package:moreway/module/place/domain/entity/place.dart';
import 'package:moreway/module/place/domain/entity/place_base.dart';
import 'package:moreway/module/place/presentation/widget/place_card.dart';
import 'package:moreway/module/location/presentation/state/map/map_bloc.dart';
import 'package:moreway/module/route/domain/entity/route_detailed.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();
  //final navigator = GetIt.instance.get<NavigationInteractor>();
  //List<PositionPoint>? route;

  @override
  void initState() {
    super.initState();
  }

  // void a(Position position) async {
  //   route = await navigator.getRoute([
  //     PositionPoint(
  //         latitude: position.point.latitude,
  //         longitude: position.point.longitude),
  //     PositionPoint(latitude: 55.375818, longitude: 86.072025)
  //   ]);
  // }

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

  Widget _buildMap(Position? position, PlaceBase? targetPlace, List<PositionPoint>? route) {
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
            polylines: route != null
                ? [
                    Polyline(
                      points: route
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
      body: BlocBuilder<MapBloc, MapState>(
          bloc: mapBloc,
          builder: (context, state) {
            //log(state.positionStatus.name.toString());
            return Stack(
              children: [
                _buildMap(state.position, state.targetPlace, state.route),
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
                    child: _buildRouteCard(
                        state.activeRoute, state.activeRoutestatus, textTheme)),
                Positioned(
                  left: screenSize.width * 0.035,
                  right: screenSize.width * 0.035,
                  bottom: screenSize.width * 0.035 + 60 + 10,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (state.targetPlace != null) ...[
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
                                      child: Text(
                                        
                                    state.targetPlace!.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontFamily: "roboto"),
                                  ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                      SizedBox(width: 10,),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildPositionButton(
                              state.positionStatus, state.position),
                        ],
                      )
                    ],
                  ),
                )
                // if (state.targetPlace != null) ...[
                //   Positioned(
                //                         bottom: screenSize.width * 0.035 + 60 + 10,
                //     left: screenSize.width * 0.035,
                //     height: 100,
                //     width: screenSize.width * 0.5,
                //       child: Container(
                //     color: AppColor.white,
                //   ))
                // ]
              ],
            );
          }
          // if (state is LocationV2Loaded) {
          //   return Stack(
          //     children: [
          //       _buildMap(state.location),
          //       Positioned(
          //           bottom: screenSize.width * 0.035 + 60 + 10,
          //           right: screenSize.width * 0.035,
          //           left: screenSize.width * 0.035,
          //           //height: 100,
          //           child: Row(
          //             mainAxisSize: MainAxisSize.max,
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             crossAxisAlignment: CrossAxisAlignment.end,
          //             children: [
          //               // Expanded(
          //               //     child: Container(
          //               //   height: 100,
          //               //   //color: AppColor.white,
          //               //   decoration: BoxDecoration(
          //               //       color: AppColor.white,
          //               //       borderRadius:
          //               //           BorderRadius.all(Radius.circular(15))),
          //               //   child: Padding(
          //               //     padding: const EdgeInsets.all(5.0),
          //               //     child: Row(
          //               //       mainAxisSize: MainAxisSize.max,
          //               //       mainAxisAlignment: MainAxisAlignment.center,
          //               //       children: [
          //               //         SquareWidget(
          //               //             child: ClipRRect(
          //               //                 borderRadius: BorderRadius.all(
          //               //                     Radius.circular(15)),
          //               //                 child: Image.network(
          //               //                     fit: BoxFit.fill,
          //               //                     "https://images-ext-1.discordapp.net/external/QNwov659XgGfaotrWzJN8h5N4h0ybB5qQoNuMIyrVyE/https/redhill-kemerovo.ru/assets/images/resources/33/zdanie-muzeya.jpg?format=webp&width=1171&height=657"))),
          //               //         Expanded(
          //               //             child: Text(
          //               //           "Красная горка",
          //               //           textAlign: TextAlign.center,
          //               //         ))
          //               //       ],
          //               //     ),
          //               //   ),
          //               // )),
          //               SizedBox(
          //                 width: 10,
          //               ),
          //               Column(
          //                 crossAxisAlignment: CrossAxisAlignment.end,
          //                 children: [
          //                   IconButton(
          //                     onPressed: () {
          //                       _mapController.move(
          //                         LatLng(state.location.point.latitude,
          //                             state.location.point.longitude),
          //                         15.0,
          //                       );
          //                     },
          //                     icon: const CircleAvatar(
          //                       radius: 25,
          //                       child: Icon(
          //                         Icons.my_location,
          //                         color: AppColor.white,
          //                         size: 20,
          //                       ),
          //                       backgroundColor: AppColor.black,
          //                     ),
          //                   ),
          //                   // ElevatedButton.icon(
          //                   //     onPressed: () {},
          //                   //     icon: const Icon(Icons.check),
          //                   //     label: const Text("Группа"),
          //                   //     style: ElevatedButton.styleFrom(
          //                   //         backgroundColor: AppColor.pink,
          //                   //         minimumSize: const Size(100, 40))),
          //                   // ElevatedButton.icon(
          //                   //     onPressed: () {},
          //                   //     icon: const Icon(Icons.check),
          //                   //     label: const Text("Прошел"),
          //                   //     style: ElevatedButton.styleFrom(
          //                   //         minimumSize: const Size(100, 40))),
          //                 ],
          //               ),
          //             ],
          //           )),
          ),
    );
  }
}

class RouteProgressBar extends StatelessWidget {
  final int currentProgress;
  final int maxProgress;

  const RouteProgressBar({
    super.key,
    required this.currentProgress,
    required this.maxProgress,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 40),
      painter: RouteProgressBarPainter(
        currentProgress: currentProgress,
        maxProgress: maxProgress,
      ),
    );
  }
}

class RouteProgressBarPainter extends CustomPainter {
  final int currentProgress;
  final int maxProgress;

  const RouteProgressBarPainter({
    required this.currentProgress,
    required this.maxProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const int radius = 5;

    final paint = Paint()
      ..color = AppColor.gray
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    final activePaint = Paint()
      ..color = AppColor.pink
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(const Offset(0, 0), Offset(size.width, 0), paint);

    if (currentProgress > 1) {
      canvas.drawLine(
          const Offset(0, 0),
          Offset(size.width / (maxProgress - 1) * (currentProgress - 1), 0),
          activePaint);
    } else {
      if (currentProgress == 1) {
        canvas.drawLine(
            const Offset(radius * 2, 0), const Offset(0, 0), activePaint);
      }
    }

    for (var i = 0; i < maxProgress; i++) {
      final x = size.width / (maxProgress - 1) * i;
      final pointPaint = i < currentProgress ? activePaint : paint;
      if (i == 0) {
        canvas.drawCircle(
            Offset(x + radius, 20), radius.toDouble(), pointPaint);
      } else if (i == maxProgress - 1) {
        const icon = Icons.flag;
        TextPainter textPainter = TextPainter(
          textDirection: TextDirection.rtl,
        );
        textPainter.text = TextSpan(
            text: String.fromCharCode(icon.codePoint),
            style: TextStyle(
                fontSize: radius * 4,
                fontFamily: icon.fontFamily,
                color: i < currentProgress ? AppColor.pink : AppColor.gray));
        textPainter.layout();
        textPainter.paint(canvas, Offset(x - radius * 2, 10));
      } else {
        canvas.drawCircle(Offset(x, 20), radius.toDouble(), pointPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
