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

class PlaceViewPage extends StatefulWidget {
  const PlaceViewPage({super.key});

  @override
  State<PlaceViewPage> createState() => _PlaceViewPageState();
}

class _PlaceViewPageState extends State<PlaceViewPage>
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

  Widget _buildPlaceName(String name) {
    return Row(
      children: [
        Flexible(
          child: Text(
            name,
            maxLines: 2,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
                fontFamily: "roboto"),
          ),
        ),
      ],
    );
  }

  Widget _buildLocation(String location) {
    return Row(
      children: [
        const Icon(
          Icons.place,
          color: AppColor.pink,
          size: 20,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          location,
          style: const TextStyle(fontSize: 12, color: AppColor.gray),
        )
      ],
    );
  }

  Widget _buildRating(double rating) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(
            color: AppColor.gray,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        RatingBarIndicator(
          rating: rating,
          itemSize: 18,
          itemCount: 5,
          itemBuilder: (context, index) {
            return const Icon(Icons.star, color: AppColor.pink);
          },
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

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: BlocBuilder<PlaceBloc, PlaceState>(builder: (context, state) {
      switch (state.loadingStatus) {
        case LoadingStatus.success:
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                pinned: true,
                stretch: true,
                elevation: 0.0,
                expandedHeight: screenSize.width,
                flexibleSpace: FlexibleSpaceBar(
                  background: ImagesCarousel(images: state.place!.images),
                  stretchModes: const [
                    StretchMode.blurBackground,
                    StretchMode.zoomBackground,
                  ],
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: Container(
                    alignment: Alignment.center,
                    height: screenSize.width * 0.1,
                    width: screenSize.width,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(15)),
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
                leading: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const CircleAvatar(
                        backgroundColor: AppColor.white,
                        child: Icon(Icons.arrow_back))),
              ),
              SliverToBoxAdapter(
                  child: Padding(
                padding: EdgeInsets.only(
                    left: screenSize.width * 0.035,
                    right: screenSize.width * 0.035),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    _buildPlaceName(state.place!.name),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildLocation(state.place!.location),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildRating(state.place!.rating),
                    SizedBox(
                      height: 10,
                    ),
                    TabBar(
                      indicatorColor: AppColor.pink,
                      labelColor: AppColor.gray,
                      tabs: const [
                        Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Text("Описание"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Text("Отзывы"),
                        ),
                      ],
                      controller: tabController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )),
            ],
            body: Padding(
              padding: EdgeInsets.only(
                  left: screenSize.width * 0.035,
                  right: screenSize.width * 0.035),
              child: TabBarView(controller: tabController, children: [
                SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Text(
                    state.place!.description,
                    textAlign: TextAlign.justify,
                  ),
                ),
                const Center(
                  child: Text("Здесь скоро будут отзывы..."),
                ),
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
