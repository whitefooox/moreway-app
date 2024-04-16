import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:moreway/module/location/presentation/state/bloc/location_bloc.dart';
import 'package:moreway/module/place/domain/entity/place.dart';
import 'package:moreway/module/place/presentation/state/bloc/places_bloc.dart';
import 'package:moreway/module/place/presentation/widget/location_filter.dart';
import 'package:moreway/module/place/presentation/widget/location_widget.dart';
import 'package:moreway/module/place/presentation/widget/place_card.dart';
import 'package:moreway/module/place/presentation/widget/search_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;
  late final PlacesBloc _placesBloc;

  @override
  void initState() {
    super.initState();
    _placesBloc = BlocProvider.of<PlacesBloc>(context);
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        _placesBloc.add(LoadPlacesEvent());
      }
    });
    _searchController.addListener(() {
      final query =
          _searchController.text.isNotEmpty ? _searchController.text : null;
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 300), () {
        _placesBloc.add(SearchPlacesEvent(query));
      });
    });
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
          selectedPlaceFilters: _placesBloc.state.filters!,
        );
      },
    );
  }
  // builder: (context) {
  //   return StatefulBuilder(
  //     builder: (context, setState) {
  //       double selectedRating = 0.0;

  //       return BlocBuilder<PlacesBloc, PlacesState>(
  //         bloc: _placesBloc,
  //         builder: (context, state) => Container(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               if (state.filterOptions == null)
  //                 const Icon(Icons.error)
  //               else
  //                 Column(
  //                   children: [
  //                     Row(
  //                       mainAxisSize: MainAxisSize.max,
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(
  //                           "Рейтинг",
  //                           style: TextStyle(fontSize: 14),
  //                         ),
  //                         RangeSlider(
  //                             max: state.filterOptions!.rangeRating[1],
  //                             min: state.filterOptions!.rangeRating[0],
  //                             divisions: state.filterOptions!.rangeRating[1]
  //                                 .toInt(),
  //                             activeColor: AppColor.black,
  //                             //inactiveColor: Colors.red,
  //                             values: RangeValues(
  //                                 state.filters!.rangeRating[0],
  //                                 state.filters!.rangeRating[1]),
  //                             onChanged: (values) {}),
  //                       ],
  //                     ),
  //                     Row(
  //                       mainAxisSize: MainAxisSize.max,
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(
  //                           "Расстояние",
  //                           style: TextStyle(fontSize: 14),
  //                         ),
  //                         RangeSlider(
  //                             max: state.filterOptions!.rangeDistance[1]
  //                                 .toDouble(),
  //                             min: state.filterOptions!.rangeDistance[0]
  //                                 .toDouble(),
  //                             divisions: state
  //                                 .filterOptions!.rangeDistance[1]
  //                                 .toInt(),
  //                             activeColor: AppColor.black,
  //                             //inactiveColor: Colors.red,
  //                             values: RangeValues(
  //                                 state.filters!.distance[0].toDouble(),
  //                                 state.filters!.distance[1].toDouble()),
  //                             onChanged: (values) {}),
  //                       ],
  //                     )
  //                   ],
  //                 ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
          left: screenSize.width * 0.035,
          right: screenSize.width * 0.035,
          top: screenSize.height * 0.01),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          titleSpacing: 0.0,
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: BlocBuilder<LocationBloc, LocationState>(
              builder: (context, state) {
            return LocationWidget(
              city: state.city,
            );
          }),
        ),
        body: CustomScrollView(
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
            const SliverAppBar(
              elevation: 0,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CategoryChip(label: "Места"),
                      SizedBox(width: 10),
                      CategoryChip(label: "Маршруты"),
                    ],
                  ),
                ],
              )),
            ),
            BlocBuilder<PlacesBloc, PlacesState>(
              bloc: _placesBloc,
              builder: (context, state) {
                if (state.places != null) {
                  return SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final place = state.places![index];
                        //return buildPlaceCard(place);
                        return PlaceCard(place: place);
                      },
                      childCount: state.places!.length,
                    ),
                  );
                } else {
                  if (state.loadingStatus == LoadingStatus.success) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: Text('Пусто'),
                      ),
                    );
                  } else if (state.loadingStatus == LoadingStatus.failure) {
                    return const SliverFillRemaining(
                      child: Center(
                        child:
                            Text('Не удалось загрузить достопримечательности'),
                      ),
                    );
                  } else {
                    return Skeletonizer.sliver(
                      enabled: true,
                      child: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final place = Place.createFake();
                            return PlaceCard(place: place);
                          },
                          childCount: 8,
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;

  const CategoryChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.white,
    );
  }
}