import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:moreway/module/location/presentation/state/location/location_bloc.dart';
import 'package:moreway/module/place/presentation/state/places/places_bloc.dart';
import 'package:moreway/module/place/presentation/widget/location_filter.dart';
import 'package:moreway/module/place/presentation/widget/location_widget.dart';
import 'package:moreway/module/place/presentation/widget/place_card.dart';
import 'package:moreway/module/place/presentation/widget/search_bar.dart';
import 'package:toggle_switch/toggle_switch.dart';

enum ViewMode { place, route }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ViewMode _viewMode = ViewMode.place;
  final _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  late final PlacesBloc _placesBloc;

  void _onScroll() {
    if (_scrollController.position.maxScrollExtent ==
        _scrollController.offset) {
      _placesBloc.add(LoadMorePlacesEvent());
    }
  }

  @override
  void initState() {
    super.initState();
    _placesBloc = BlocProvider.of<PlacesBloc>(context);
    _scrollController.addListener(_onScroll);
    _searchController.addListener(() {
      log(_searchController.text);
      final query =
          _searchController.text.isEmpty ? null : _searchController.text;
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 300), () {
        _placesBloc.add(SearchPlacesEvent(query));
      });
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onClickFilter() {
    showMaterialModalBottomSheet(
      useRootNavigator: true,
      context: context,
      builder: (BuildContext context) {
        return LocationFilter(
          filtersOptions: _placesBloc.state.filterOptions!,
          onSubmit: (filters) {
            _placesBloc.add(UpdateFiltersEvent(filters: filters));
            Navigator.maybePop(context);
          },
          selectedPlaceFilters: _placesBloc.state.filters,
        );
      },
    );
  }

  void _onClickPlace(String id) {
    context.go("/home/place/$id");
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(
        left: screenSize.width * 0.035,
        right: screenSize.width * 0.035,
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          titleSpacing: 0.0,
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: const Text("Главная"),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Badge(
                    child: Icon(
                  Icons.notifications,
                )))
          ],
        ),
        body: RefreshIndicator(
          color: AppColor.pink,
          onRefresh: () async {
            _placesBloc.add(LoadPlacesEvent());
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: 45,
                flexibleSpace: AppSearchBar(
                  controller: _searchController,
                  onClickFilter: _onClickFilter,
                ),
                pinned: true,
                floating: true,
                elevation: 0,
                surfaceTintColor: Colors.transparent,
              ),
              SliverAppBar(
                elevation: 0,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                    background: Center(
                  child: ToggleSwitch(
                    minWidth: 100,
                    minHeight: 35,
                    inactiveBgColor: AppColor.gray.withOpacity(0.5),
                    totalSwitches: 2,
                    initialLabelIndex: _viewMode == ViewMode.place ? 0 : 1,
                    labels: const ['Места', 'Маршруты'],
                    radiusStyle: true,
                    cornerRadius: 15.0,
                    activeBgColor: const [AppColor.black],
                    onToggle: (index) {
                      if (index == 0) {
                        setState(() {
                          _viewMode = ViewMode.place;
                        });
                      } else {
                        setState(() {
                          _viewMode = ViewMode.route;
                        });
                      }
                    },
                  ),
                )),
              ),
              BlocBuilder<PlacesBloc, PlacesState>(
                bloc: _placesBloc,
                builder: (context, state) {
                  if (state.places != null) {
                    if (state.places!.isEmpty) {
                      return const SliverFillRemaining(
                          child: Center(child: Text("Не найдено")));
                    } else {
                      return SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5.0,
                          crossAxisSpacing: 5.0,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final place = state.places![index];
                            return InkWell(
                                onTap: () => _onClickPlace(place.id),
                                child: PlaceCard(place: place));
                          },
                          childCount: state.places!.length,
                        ),
                      );
                    }
                  } else {
                    if (state.status == PlacesStatus.failure) {
                      return const SliverFillRemaining(
                        child: Center(
                          child: Text('Что-то сломалось'),
                        ),
                      );
                    } else {
                      return const SliverFillRemaining(
                          child: Center(
                              child: CircularProgressIndicator(
                        color: AppColor.pink,
                      )));
                    }
                  }
                },
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  width: screenSize.width,
                  height: 60 + screenSize.width * 0.035 * 2,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
