import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/core/const/assets.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:moreway/module/place/domain/entity/place.dart';
import 'package:moreway/module/route/domain/entity/route_raw.dart';
import 'package:moreway/module/route/presentation/state/builder/route_builder_bloc.dart';
import 'package:moreway/module/route/presentation/view/widget/create_route_name_dialog.dart';
import 'package:moreway/module/route/presentation/view/widget/dashed_vertical_line.dart';
import 'package:moreway/module/route/presentation/view/widget/few_places_dialog.dart';
import 'package:moreway/module/route/presentation/view/widget/route_created_popup.dart';

class RouteBuilderPage extends StatefulWidget {
  const RouteBuilderPage({super.key});

  @override
  _RouteBuilderPageState createState() => _RouteBuilderPageState();
}

class _RouteBuilderPageState extends State<RouteBuilderPage> {
  late final RouteBuilderBloc _builderBloc;
  bool isEditMode = false;
  RouteRaw? editRoute;

  Widget _buildRouteBuilderListViewForEditMode(
      List<Place> points, TextTheme textTheme) {
    return ReorderableListView.builder(
      onReorder: (oldIndex, newIndex) {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        final place = points[oldIndex];
        points
          ..removeAt(oldIndex)
          ..insert(newIndex, place);
      },
      itemCount: points.length,
      itemBuilder: (context, index) {
        return Slidable(
          key: Key(points[index].id),
          endActionPane: ActionPane(
            extentRatio: 0.2,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                autoClose: true,
                borderRadius: BorderRadius.circular(15),
                flex: 1,
                onPressed: (contex) {
                  setState(() {
                    points.removeAt(index);
                  });
                },
                backgroundColor: AppColor.pink,
                foregroundColor: Colors.white,
                icon: Icons.close,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColor.pink,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: AppColor.white,
                  child: Text(
                    "${index + 1}",
                    style: const TextStyle(color: AppColor.black),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                  child: Card(
                child: ListTile(
                  subtitle: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.place,
                        color: AppColor.pink,
                        size: textTheme.titleSmall!.fontSize,
                      ),
                      Text(
                        "${points[index].distance.toStringAsFixed(1)} км",
                        style: textTheme.titleSmall!
                            .copyWith(color: AppColor.gray),
                      )
                    ],
                  ),
                  leading: CircleAvatar(
                      child: ClipOval(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        points[index].image,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                              child: Icon(Icons.not_interested));
                        },
                      ),
                    ),
                  )),
                  title: Text(
                    points[index].name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontFamily: "roboto"),
                  ),
                ),
              ))
            ],
          ),
        );
      },
    );
  }

  Widget _buildRouteBuilderListView(List<Place> points, TextTheme textTheme) {
    return ListView.separated(
      itemCount: points.length,
      itemBuilder: (context, index) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColor.pink,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: AppColor.white,
                child: Text(
                  "${index + 1}",
                  style: const TextStyle(color: AppColor.black),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
                child: Card(
              child: ListTile(
                subtitle: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.place,
                      color: AppColor.pink,
                      size: textTheme.titleSmall!.fontSize,
                    ),
                    Text(
                      "${points[index].distance.toStringAsFixed(1)} км",
                      style:
                          textTheme.titleSmall!.copyWith(color: AppColor.gray),
                    )
                  ],
                ),
                leading: CircleAvatar(
                    child: ClipOval(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      points[index].image,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(child: Icon(Icons.not_interested));
                      },
                    ),
                  ),
                )),
                title: Text(
                  points[index].name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontFamily: "roboto"),
                ),
              ),
            ))
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Row(
          children: [
            SizedBox(
                height: 40,
                width: 40,
                child: Center(
                    child: DashedVerticalLine(
                  dashWidth: 5,
                  color: AppColor.pink,
                  height: double.infinity,
                  dashSpace: 5,
                  dashHeight: 10,
                )))
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _builderBloc = BlocProvider.of<RouteBuilderBloc>(context);
  }

  void _onEditMode(bool isEnable) {
    setState(() {
      isEditMode = isEnable;
    });
    if (isEditMode == true) {
      setState(() {
        editRoute =
            RouteRaw(points: List.from(_builderBloc.state.route!.points));
      });
    }
  }

  void _onSave() {
    _builderBloc.add(UpdateAllRouteBuilderEvent(route: editRoute!));
    _onEditMode(false);
  }

  void _onCreate(BuildContext context) async {
    final placesCount = _builderBloc.state.placesCount;
    if (placesCount >= 2 && placesCount <= 15) {
      final routeName = await showCreateRouteNameDialog(context);
      if (routeName != null && routeName.isNotEmpty) {
        _builderBloc.add(CreateRouteBuilderEvent(name: routeName));
      }
    } else {
      await showFewPlacesDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return BlocListener<RouteBuilderBloc, RouteBuilderState>(
      bloc: _builderBloc,
      listener: (context, state) {
        if(state.operationStatus == RouteBuilderOperationStatus.created){
          showDialog(context: context, builder:(context) => const RouteCreatedPopup(),);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Конструктор'),
          actions: [
            BlocBuilder<RouteBuilderBloc, RouteBuilderState>(
              bloc: _builderBloc,
              builder: (context, state) {
                if (state.operationStatus ==
                    RouteBuilderOperationStatus.loadingUpdating) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: AppColor.pink,
                        )),
                  );
                } else {
                  return IconButton(
                      onPressed: () => _onEditMode(!isEditMode),
                      icon: Icon(!isEditMode ? Icons.edit : Icons.undo));
                }
              },
            ),
            if (isEditMode) ...[
              IconButton(onPressed: _onSave, icon: const Icon(Icons.check))
            ],
          ],
        ),
        body: BlocBuilder<RouteBuilderBloc, RouteBuilderState>(
          bloc: _builderBloc,
          builder: (context, state) {
            if (state.routeStatus == LoadingStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.routeStatus == LoadingStatus.success) {
              if (isEditMode ||
                  state.operationStatus ==
                      RouteBuilderOperationStatus.loadingUpdating) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: screenSize.width * 0.035,
                    right: screenSize.width * 0.035,
                  ),
                  child: _buildRouteBuilderListViewForEditMode(
                      editRoute!.points, textTheme),
                );
              } else {
                if(state.route!.points.isEmpty){
                  return EmptyRouteBuilder();
                  //return const Center(child: Text("Здесь пусто...\nВыберете места для путешествий"));
                } else {
                  return Stack(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                          left: screenSize.width * 0.035,
                          right: screenSize.width * 0.035,
                        ),
                        child: _buildRouteBuilderListView(
                            state.route!.points, textTheme)),
                    Positioned(
                      bottom: screenSize.width * 0.035 + 60 + 10,
                      right: screenSize.width * 0.035,
                      child: ElevatedButton.icon(
                          onPressed: () => _onCreate(context),
                          icon: const Icon(Icons.explore_outlined),
                          label: const Text("Создать")),
                    )
                  ],
                );
                }
              }
            } else {
              return const Center(
                child: Text("Ошибка"),
              );
            }
          },
        ),
      ),
    );
  }
}

class EmptyRouteBuilder extends StatelessWidget {
  const EmptyRouteBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(Assets.panelIconImage, height: 50),
          SizedBox(height: 24),
          Text(
            "Здесь пусто!",
            style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold)
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              "Начните добавлять интересные места, чтобы спланировать свое путешествие.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }
}