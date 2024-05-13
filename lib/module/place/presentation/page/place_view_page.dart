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
import 'package:moreway/module/place/presentation/widget/review_card.dart';

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
    return 
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
    return RatingBarIndicator(
      rating: rating,
      itemSize: 18,
      itemCount: 5,
      itemBuilder: (context, index) {
        return const Icon(Icons.star, color: AppColor.pink);
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

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColor.pink,
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(double width, List<String> images) {
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
              _buildSliverAppBar(screenSize.width, state.place!.images),
              SliverToBoxAdapter(
                  child: Padding(
                padding: EdgeInsets.only(
                    left: screenSize.width * 0.035,
                    right: screenSize.width * 0.035),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildPlaceName(state.place!.name),
                          _buildRating(state.place!.rating),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildLocation(state.place!.location),
                          //_buildRating(state.place!.rating),
                        ],
                      ),
                      // _buildLocation(state.place!.location),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // _buildRating(state.place!.rating),
                      // SizedBox(
                      //   height: 10,
                      // ),
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
                  child: Text(
                    state.place!.description,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Stack(children: [
                  ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: 40,
                    itemBuilder: (context, index) => ReviewCard(
                        avatarUrl:
                            "https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_square.jpg",
                        name: "Мокович",
                        date: DateTime(2024, 12, 1),
                        rating: 4.3,
                        text:
                            '''Ого, братва, этот замок - просто бомба! Такие толстенные стены, наверняка раньше тут жили крутые пацаны. А может, даже сами рыцари тусовались! Эх, жаль в наше время таких тёрок не строят. Ну ничего, мы и в своём районе найдём, где потусоваться. Кстати, кто-нибудь знает, тут рядом есть нормальные забегаловки? После осмотра достопримечательностей ужасно клинит по шавухе!'''),
                  ),
                  // Positioned(
                  //   bottom: screenSize.width * 0.035,
                  //   child: Container(
                  //     color: Colors.red,
                  //     width: screenSize.width,
                  //     height: 20,
                  //   )
                  // )
                ])
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
