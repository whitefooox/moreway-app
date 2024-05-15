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

  Widget _buildProperties(String location, TextTheme textTheme, double rating, double distance) {
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
        SizedBox(
          width: 20,
        ),
        Icon(
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
      child: CircularProgressIndicator(
        color: AppColor.pink,
      ),
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
            onPressed: () async {
              //context.push("/home/place/$placeId/create-review");
              final a = await showDialog<bool>(context: context, builder:(context) => SimpleDialog());
            },
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
                          _buildProperties(state.place!.location, textTheme, state.place!.rating, state.place!.distance),
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
                            padding: EdgeInsets.only(top: 8, bottom: 8),
                            child: Text(
                              "Описание",
                              style: textTheme.bodyMedium,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 8),
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
                child: Stack(
                  children: [
                    TabBarView(controller: tabController, children: [
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
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Поделитесь своими впечатлениями",
                                      style: textTheme.bodyLarge!.copyWith(
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  RatingBar.builder(
                                    initialRating: 0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 30,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: AppColor.pink,
                                    ),
                                    onRatingUpdate: (rating) {
                                      // Handle rating update
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  TextField(
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      hintText: "Напишите свой отзыв...",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    style: textTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: 5),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Handle review submission
                                    },
                                    child: const Text("Отправить"),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              );
                            } else {
                              return ReviewCard(
                                  review: state.reviews![index - 1]);
                            }
                          }),
                    ]),
                    // Positioned(
                    //     bottom: screenSize.width * 0.035,
                    //     left: 0,
                    //     right: 0,
                    //     child: FractionallySizedBox(
                    //       widthFactor: 1,
                    //       child: ElevatedButton(
                    //           onPressed: () {},
                    //           child: const Text("Добавить в маршрут")),
                    //     ))
                  ],
                )),
          );
        case LoadingStatus.failure:
          return _buildError();
        default:
          return _buildLoading();
      }
    }));
  }
}
