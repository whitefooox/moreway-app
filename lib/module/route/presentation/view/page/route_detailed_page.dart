import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:moreway/module/location/presentation/widget/route_map_tile.dart';
import 'package:moreway/module/route/presentation/state/route/route_bloc.dart';
import 'package:moreway/module/route/presentation/view/widget/route_point_list.dart';

class RouteDetailedPage extends StatefulWidget {
  const RouteDetailedPage({super.key});

  @override
  State<RouteDetailedPage> createState() => _RouteDetailedPageState();
}

class _RouteDetailedPageState extends State<RouteDetailedPage>
    with TickerProviderStateMixin {
  late final RouteBloc _routeBloc;
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    _routeBloc = BlocProvider.of<RouteBloc>(context);
  }

  void _like(){
    _routeBloc.add(LikeRouteEvent());
  }

  void _unlike(){
    _routeBloc.add(UnlikeRouteEvent());
  }

  Widget _buildSliverAppBar(double width) {
    return BlocBuilder<RouteBloc, RouteState>(
      bloc: _routeBloc,
      builder: (context, state) {
        return SliverAppBar(
          pinned: true,
          expandedHeight: width * 1.2,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              children: [
                RouteMapTail(
                  routePoints: state.route!.points,
                  routeCoordinates: state.routeCoordinates,
                ),
                                              Positioned(
            bottom: width * 0.1 + 10,
            right: 10.0,
            child: FloatingActionButton.extended(
              onPressed: () {},
              label: const Text("В путь", style: TextStyle(color: AppColor.white),),
              icon: const Icon(Icons.hiking, color: AppColor.white,),
              backgroundColor: AppColor.black,
            ),
          ),
              ],
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
          actions: [
            IconButton(
                onPressed: state.route!.isFavorite! ? _unlike : _like,
                icon: CircleAvatar(
                    backgroundColor: AppColor.white,
                    child: Icon(
                      state.route!.isFavorite != true ? Icons.favorite_outline : Icons.favorite,
                      color: state.route!.isFavorite != true ? AppColor.black : AppColor.pink,
                    ))),
          ],
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
            return Stack(
              children: [
                NestedScrollView(
                    scrollBehavior: ScrollBehavior(),
                    headerSliverBuilder: (context, innerBoxIsScrolled) =>
                        [_buildSliverAppBar(screenSize.width)],
                    body: Container(
                      color: AppColor.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: screenSize.width * 0.035,
                            right: screenSize.width * 0.035),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Flexible(
                                    child: Text(
                                  maxLines: 2,
                                  state.route!.name,
                                  style: textTheme.titleLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: "roboto"),
                                )),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                CircleAvatar(
                                  radius: textTheme.titleMedium!.fontSize,
                                  child: ClipOval(
                                    child: Image.network(
                                        state.route!.creator.avatarUrl),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Text(
                                    state.route!.creator.name,
                                    style: textTheme.titleMedium!.copyWith(
                                        color: AppColor.gray,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Icon(
                                  Icons.star,
                                  color: AppColor.pink,
                                  size: 24,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  state.route!.rating.toStringAsFixed(1),
                                  style: textTheme.titleMedium!
                                      .copyWith(color: AppColor.gray),
                                )
                              ],
                            ),
                            TabBar(
                              indicatorColor: AppColor.pink,
                              labelColor: AppColor.gray,
                              tabs: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Text(
                                    "Места",
                                    style: textTheme.bodyMedium,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Text(
                                    "Отзывы",
                                    style: textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                              controller: tabController,
                            ),
                            Expanded(
                                child: Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: RoutePointsList(
                                      points: state.route!.points
                                          .map((e) => e.place)
                                          .toList()),
                                ))
                          ],
                        ),
                      ),
                    )),
          //                     Positioned(
          //   bottom: 16.0,
          //   right: 16.0,
          //   child: FloatingActionButton.extended(
          //     onPressed: () {},
          //     label: const Text("Начать", style: TextStyle(color: AppColor.white),),
          //     icon: const Icon(Icons.play_arrow, color: AppColor.white,),
          //     backgroundColor: AppColor.black,
          //   ),
          // ),
              ],
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
