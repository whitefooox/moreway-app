import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:moreway/module/location/domain/entity/position.dart';
import 'package:moreway/module/location/presentation/widget/route_map_tile.dart';
import 'package:moreway/module/route/domain/entity/route_detailed.dart';
import 'package:moreway/module/route/domain/entity/route_point_detailed.dart';
import 'package:moreway/module/route/presentation/state/route/route_bloc.dart';
import 'package:moreway/module/route/presentation/view/widget/route_point_list.dart';
import 'package:osrm/osrm.dart';
import 'dart:math' as math;

class RouteDetailedPage extends StatefulWidget {
  const RouteDetailedPage({super.key});

  @override
  State<RouteDetailedPage> createState() => _RouteDetailedPageState();
}

class _RouteDetailedPageState extends State<RouteDetailedPage> {
  late final RouteBloc _routeBloc;

  @override
  void initState() {
    super.initState();
    _routeBloc = BlocProvider.of<RouteBloc>(context);
  }

  Widget _buildSliverAppBar(double width) {
    return BlocBuilder<RouteBloc, RouteState>(
      bloc: _routeBloc,
      builder: (context, state) {
        return SliverAppBar(
          pinned: true,
          expandedHeight: width,
          flexibleSpace: FlexibleSpaceBar(
            background: RouteMapTail(
              routePoints: state.route!.points,
              routeCoordinates: state.routeCoordinates,
            ),
            stretchModes: const [
              StretchMode.blurBackground,
              StretchMode.zoomBackground,
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Container(
              alignment: Alignment.center,
              height: width * 0.1,
              width: width,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  color: AppColor.white),
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColor.gray,
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
            ),
          ),
          actions: [],
          leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const CircleAvatar(
                  backgroundColor: AppColor.white,
                  child: Icon(Icons.arrow_back))),
        );
      },
    );
  }

  Widget _buildError() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: AppColor.pink,
            size: 50,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Что-то сломалось :(",
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Детали маршрута'),
      // ),
      body: BlocBuilder<RouteBloc, RouteState>(
        builder: (context, state) {
          if (state.routeDetailedStatus == LoadingStatus.success) {
            return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) =>
                    [_buildSliverAppBar(screenSize.width)],
                body: 
                    RoutePointsList(
                        points:
                            state.route!.points.map((e) => e.place).toList())
                  
                );
          }
          if (state.routeDetailedStatus == LoadingStatus.failure) {
            return _buildError();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
