import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:moreway/core/di/inject.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:moreway/module/location/domain/entity/position.dart';
import 'package:moreway/module/location/presentation/state/location/location_bloc.dart';
import 'package:moreway/module/location/presentation/state/location_v2/location_v2_bloc.dart';

class MapPage extends StatefulWidget {
  MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
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
          child: CircleAvatar(
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

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationV2Bloc>(context);

    return Scaffold(
      body: BlocBuilder<LocationV2Bloc, LocationV2State>(
        bloc: locationBloc,
        builder: (context, state) {
          if (state is LocationV2Loading) {
            return CircularProgressIndicator();
          }
          if (state is LocationV2Loaded) {
            return FlutterMap(
                options: MapOptions(
                    initialCenter: LatLng(state.location.point.latitude,
                        state.location.point.longitude),
                    initialZoom: 16,
                    minZoom: 8,
                    maxZoom: 16,
                    interactionOptions:
                        InteractionOptions(flags: InteractiveFlag.all)),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  MarkerLayer(
                      markers: [_buildCurrentPositionMarker(state.location)])
                ]);
          } else {
            return Text("Все сломалось");
          }
        },
        // builder: (context, state) => FlutterMap(
        //     options: MapOptions(
        //         initialCenter: LatLng(state.currentPosition!.latitude,
        //             state.currentPosition!.longitude),
        //         initialZoom: 16,
        //         minZoom: 8,
        //         maxZoom: 16,
        //         interactionOptions:
        //             InteractionOptions(flags: InteractiveFlag.all)),
        //     children: [
        //       TileLayer(
        //         urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        //       ),
        //       MarkerLayer(markers: [
        //         _buildCurrentPositionMarker(LatLng(
        //             state.currentPosition!.latitude,
        //             state.currentPosition!.longitude))
        //       ])
        //     ]),
      ),
    );
  }
}
