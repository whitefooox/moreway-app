import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:moreway/module/location/presentation/state/bloc/location_bloc.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);

    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        bloc: locationBloc,
        builder: (context, state) => FlutterMap(
            options: MapOptions(
                initialCenter: LatLng(state.currentPosition!.latitude,
                    state.currentPosition!.longitude),
                initialZoom: 11,
                interactionOptions:
                    InteractionOptions(flags: InteractiveFlag.all)),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              MarkerLayer(markers: [
                Marker(
                    point: LatLng(state.currentPosition!.latitude,
                        state.currentPosition!.longitude),
                    child: Icon(Icons.place))
              ])
            ]),
      ),
    );
  }
}
