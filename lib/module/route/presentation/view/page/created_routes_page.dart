import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:moreway/module/route/presentation/state/created/created_routes_bloc.dart';
import 'package:moreway/module/route/presentation/state/favorite/favorite_routes_bloc.dart';
import 'package:moreway/module/route/presentation/view/widget/route_list_tile.dart';

class CreatedRoutesPage extends StatefulWidget {
  const CreatedRoutesPage({super.key});

  @override
  State<CreatedRoutesPage> createState() => _CreatedRoutesPageState();
}

class _CreatedRoutesPageState extends State<CreatedRoutesPage> {
  late final ScrollController _scrollController;
  late final CreatedRoutesBloc _createdRoutesBloc;

  void _onScroll() {
    if (_scrollController.position.maxScrollExtent ==
        _scrollController.offset) {
      _createdRoutesBloc.add(LoadMoreCreatedRoutesEvent());
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _createdRoutesBloc = BlocProvider.of<CreatedRoutesBloc>(context);
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
            BlocProvider.of<CreatedRoutesBloc>(context)
                .add(LoadCreatedRoutesEvent());
          },
          child: BlocBuilder<CreatedRoutesBloc, CreatedRoutesState>(
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
                        return InkWell(
                          child: RouteListTile(route: route),
                          onTap: () {
                            context.go(
                                "/profile/favorite-routes/route/${route.id}");
                          },
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
