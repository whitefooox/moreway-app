import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  PlaceViewPage({super.key});

  @override
  State<PlaceViewPage> createState() => _PlaceViewPageState();
}

class _PlaceViewPageState extends State<PlaceViewPage>
    with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
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

  Widget _buildPlaceView(BuildContext context, PlaceDetailed place) {
    final screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
            width: screenSize.width,
            height: screenSize.width,
            child: ImagesCarousel(images: place.images)),
        Positioned(
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(35))),
              width: screenSize.width,
              height: screenSize.height - screenSize.width * 0.9,
              child: Padding(
                padding: EdgeInsets.only(
                    left: screenSize.width * 0.035,
                    right: screenSize.width * 0.035,
                    top: screenSize.width * 0.05),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPlaceName(place.name),
                      const SizedBox(
                        height: 10,
                      ),
                      _buildLocation(place.location),
                      const SizedBox(
                        height: 10,
                      ),
                      _buildRating(place.rating),
                      const SizedBox(
                        height: 30,
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
                          Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 8),
                            child: Text("На карте"),
                          )
                        ],
                        controller: tabController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: TabBarView(controller: tabController, children: [
                          SingleChildScrollView(
                            child: Text(
                              place.description,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          Center(
                            child: Text("Здесь скоро будут отзывы..."),
                          ),
                          Center(
                            child: Text("Карта..."),
                          )
                        ]),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ))
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const CircleAvatar(
                backgroundColor: AppColor.white,
                child: Icon(Icons.arrow_back))),
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        child: BlocBuilder<PlaceBloc, PlaceState>(
          builder: (context, state) {
            switch (state.loadingStatus) {
              case LoadingStatus.success:
                return _buildPlaceView(context, state.place!);
              case LoadingStatus.failure:
                return _buildError();
              default:
                return _buildLoading();
            }
          },
        ),
      ),
    );
  }
}
