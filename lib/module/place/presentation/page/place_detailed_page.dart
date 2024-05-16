import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:moreway/module/place/domain/entity/place_detailed.dart';
import 'package:moreway/module/place/presentation/state/place/place_bloc.dart';
import 'package:moreway/module/place/presentation/widget/images_carousel.dart';
import 'package:moreway/module/review/presentation/view/widget/create_review_dialog.dart';
import 'package:moreway/module/review/presentation/view/widget/review_card.dart';
import 'package:readmore/readmore.dart';

class PlaceDetailedPage extends StatefulWidget {
  const PlaceDetailedPage({super.key});

  @override
  State<PlaceDetailedPage> createState() => _PlaceDetailedPageState();
}

class _PlaceDetailedPageState extends State<PlaceDetailedPage>
    with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget _buildPlaceName(String name, TextTheme textTheme) {
    return Flexible(
      child: Text(
        name,
        maxLines: 2,
        style: textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
            fontFamily: "roboto"),
      ),
    );
  }

  Widget _buildProperties(
      String location, TextTheme textTheme, double rating, double distance) {
    return Row(
      children: [
        const Icon(
          Icons.place,
          color: AppColor.pink,
          size: 24,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          "$location (${distance.toStringAsFixed(1)} км)",
          style: textTheme.titleMedium!.copyWith(color: AppColor.gray),
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
          rating.toStringAsFixed(1),
          style: textTheme.titleMedium!.copyWith(color: AppColor.gray),
        )
      ],
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

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  SliverAppBar _buildSliverAppBar(
      double width, List<String> images, String placeId) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: width,
      flexibleSpace: FlexibleSpaceBar(
        background: ImagesCarousel(images: images),
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
            onPressed: () async {},
            icon: const CircleAvatar(
              backgroundColor: AppColor.white,
              child: Icon(Icons.add),
            ))
      ],
      leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const CircleAvatar(
              backgroundColor: AppColor.white, child: Icon(Icons.arrow_back))),
    );
  }

  void _createReviewDialog() async {
    final review = await showCreateReviewDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        body: BlocBuilder<PlaceBloc, PlaceState>(builder: (context, state) {
      switch (state.loadingStatus) {
        case LoadingStatus.success:
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              _buildSliverAppBar(
                  screenSize.width, state.place!.images, state.placeId!),
              SliverToBoxAdapter(
                  child: Padding(
                padding: EdgeInsets.only(
                    left: screenSize.width * 0.035,
                    right: screenSize.width * 0.035),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildPlaceName(state.place!.name, textTheme),
                          const SizedBox(
                            width: 10,
                          ),
                          //_buildRating(state.place!.rating),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildProperties(state.place!.location, textTheme,
                              state.place!.rating, state.place!.distance),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TabBar(
                        indicatorColor: AppColor.pink,
                        labelColor: AppColor.gray,
                        tabs: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Text(
                              "Описание",
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
                    ],
                  ),
                ),
              )),
            ],
            body: Padding(
              padding: EdgeInsets.only(
                  left: screenSize.width * 0.035,
                  right: screenSize.width * 0.035),
              child: TabBarView(controller: tabController, children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ReadMoreText(
                    state.place!.description,
                    colorClickableText: AppColor.pink,
                    trimExpandedText: " Скрыть",
                    trimCollapsedText: "Читать дальше",
                  ),
                ),
                ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state.reviews!.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return ElevatedButton(
                          onPressed: _createReviewDialog,
                          child: Text(
                            "Оставить отзыв",
                            style: textTheme.bodyMedium!
                                .copyWith(color: AppColor.white),
                          ),
                        );
                      } else {
                        return ReviewCard(review: state.reviews![index - 1]);
                      }
                    }),
              ]),
            ),
          );
        case LoadingStatus.failure:
          return _buildError();
        default:
          return _buildLoading();
      }
    }));
  }
}
