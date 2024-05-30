import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:moreway/module/location/domain/entity/position_point.dart';
import 'package:moreway/module/route/domain/entity/route_point_detailed.dart';

class RouteMapTail extends StatelessWidget {
  final List<RoutePointDetailed> routePoints;
  final List<PositionPoint>? routeCoordinates;

  const RouteMapTail(
      {super.key, required this.routePoints, this.routeCoordinates});

  @override
  Widget build(BuildContext context) {
    LatLngBounds? bounds;
    if (routeCoordinates != null && routeCoordinates!.isNotEmpty) {
      bounds = LatLngBounds.fromPoints(routeCoordinates!
          .map((e) => LatLng(e.latitude, e.longitude))
          .toList());
    } else if (routePoints.isNotEmpty) {
      bounds = LatLngBounds.fromPoints(
          routePoints.map((e) => LatLng(e.place.lat, e.place.lon)).toList());
    }

    return FlutterMap(
      options: MapOptions(
        bounds: bounds,
        boundsOptions: const FitBoundsOptions(padding: EdgeInsets.all(50.0)),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
        PolylineLayer(
          polylines: routeCoordinates != null
              ? [
                  Polyline(
                    points: routeCoordinates!
                        .map((e) => LatLng(e.latitude, e.longitude))
                        .toList(),
                    strokeWidth: 4.0,
                    color: AppColor.pink,
                  ),
                ]
              : [],
        ),
        MarkerLayer(
          markers: [
            ...routePoints.map((point) {
              return Marker(
                point: LatLng(point.place.lat, point.place.lon),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: AppColor.pink,
                      child: CircleAvatar(
                        backgroundColor: AppColor.white,
                        radius: 12,
                        child: Text(
                          point.index.toString(),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ],
    );
  }
}
