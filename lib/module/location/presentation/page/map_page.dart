import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:moreway/module/location/domain/entity/position.dart';
import 'package:moreway/module/location/presentation/state/location_v2/location_v2_bloc.dart';
import 'package:moreway/module/place/domain/entity/place.dart';
import 'package:moreway/module/place/presentation/widget/place_card.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
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

  Widget _buildMap(Position position) {
    return FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          zoom: 15,
          initialCenter:
              LatLng(position.point.latitude, position.point.longitude),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          MarkerLayer(markers: [_buildCurrentPositionMarker(position)]),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationV2Bloc>(context);
    final screenSize = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Карта"),
      // ),
      body: BlocBuilder<LocationV2Bloc, LocationV2State>(
        bloc: locationBloc,
        builder: (context, state) {
          if (state is LocationV2Loading) {
            return const CircularProgressIndicator();
          }
          if (state is LocationV2Loaded) {
            return Stack(
              children: [
                _buildMap(state.location),
                Positioned(
                    bottom: screenSize.width * 0.035 + 60 + 10,
                    right: screenSize.width * 0.035,
                    left: screenSize.width * 0.035,
                    //height: 100,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Expanded(
                        //     child: Container(
                        //       height: 100,
                        //   //color: AppColor.white,
                        //   decoration: BoxDecoration(
                        //       color: AppColor.white,
                        //       borderRadius:
                        //           BorderRadius.all(Radius.circular(15))),
                        // )),
                        // SizedBox(
                        //   width: 10,
                        // ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                _mapController.move(
                                  LatLng(state.location.point.latitude,
                                      state.location.point.longitude),
                                  15.0,
                                );
                              },
                              icon: const CircleAvatar(
                                radius: 25,
                                child: Icon(
                                  Icons.my_location,
                                  color: AppColor.white,
                                  size: 20,
                                ),
                                backgroundColor: AppColor.black,
                              ),
                            ),
                            // ElevatedButton.icon(
                            //     onPressed: () {},
                            //     icon: const Icon(Icons.check),
                            //     label: const Text("Группа"),
                            //     style: ElevatedButton.styleFrom(
                            //       backgroundColor: AppColor.pink,
                            //         minimumSize: const Size(100, 40))),
                            // ElevatedButton.icon(
                            //     onPressed: () {},
                            //     icon: const Icon(Icons.check),
                            //     label: const Text("Прошел"),
                            //     style: ElevatedButton.styleFrom(
                            //         minimumSize: const Size(100, 40))),
                          ],
                        ),
                      ],
                    )),
                // Positioned(
                //     top: screenSize.width * 0.035,
                //     left: screenSize.width * 0.035,
                //     right: screenSize.width * 0.035,
                //     child: Container(
                //       decoration: BoxDecoration(
                //           color: Colors.white.withOpacity(0.5),
                //           borderRadius: BorderRadius.all(Radius.circular(15))),
                //       child: Padding(
                //         padding: const EdgeInsets.all(5.0),
                //         child: Column(
                //           mainAxisSize: MainAxisSize.min,
                //           children: [
                //             Text(
                //               "Название маршрута",
                //               style: textTheme.titleLarge!.copyWith(
                //                 color: AppColor.black,
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             ),
                //             const SizedBox(
                //               height: 10,
                //             ),
                //             const Padding(
                //               padding: EdgeInsets.all(5.0),
                //               child: RouteProgressBar(
                //                 currentProgress: 3,
                //                 maxProgress: 15,
                //               ),
                //             )
                //           ],
                //         ),
                //       ),
                //     ))
              ],
            );
          } else {
            return const Text("Все сломалось");
          }
        },
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
