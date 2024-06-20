import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:moreway/module/route/presentation/state/favorite/favorite_routes_bloc.dart';
import 'package:moreway/module/route/presentation/view/widget/route_list_tile.dart';

class FavoriteRoutesPage extends StatefulWidget {
  const FavoriteRoutesPage({super.key});

  @override
  State<FavoriteRoutesPage> createState() => _FavoriteRoutesPageState();
}

class _FavoriteRoutesPageState extends State<FavoriteRoutesPage> {
  late final ScrollController _scrollController;
  late final FavoriteRoutesBloc _favoriteRoutesBloc;

  void _onScroll() {
    if (_scrollController.position.maxScrollExtent ==
        _scrollController.offset) {
      _favoriteRoutesBloc.add(LoadMoreFavoriteRoutesEvent());
    }
  }

  void _removeFavoriteRoute(String id) {
    _favoriteRoutesBloc.add(RemoveFavoriteRouteEvent(id));
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _favoriteRoutesBloc = BlocProvider.of<FavoriteRoutesBloc>(context);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Избранные маршруты"),
        ),
        body: RefreshIndicator(
          color: AppColor.pink,
          onRefresh: () async {
            BlocProvider.of<FavoriteRoutesBloc>(context)
                .add(LoadFavoriteRoutesEvent());
          },
          child: BlocBuilder<FavoriteRoutesBloc, FavoriteRoutesState>(
            builder: (context, state) {
              if (state.routes != null) {
                if (state.routes!.isEmpty) {
                  return Center(
                    child: Text("Не найдено"),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.all(screenSize.width * 0.035),
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      itemCount: state.routes!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final route = state.routes![index];
                        return Slidable(
                          key: ValueKey(route.id),
                          endActionPane: ActionPane(
                            extentRatio: 0.2,
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                autoClose: true,
                                borderRadius: BorderRadius.circular(15),
                                flex: 1,
                                onPressed: (contex) {
                                  _removeFavoriteRoute(route.id);
                                },
                                backgroundColor: AppColor.pink,
                                foregroundColor: Colors.white,
                                icon: Icons.remove_circle,
                              ),
                            ],
                          ),
                          child: InkWell(
                            child: RouteListTile(route: route),
                            onTap: () {
                              context.go(
                                  "/profile/favorite-routes/route/${route.id}");
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
              } else {
                if (state.status == LoadingStatus.failure) {
                  return Center(child: Text('Что-то сломалось'));
                } else {
                  return Center(
                    child: CircularProgressIndicator(color: AppColor.pink),
                  );
                }
              }
            },
          ),
        ));
  }
}
