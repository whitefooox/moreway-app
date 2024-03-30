import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/core/snackbar.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:moreway/module/location/presentation/state/bloc/location_bloc.dart';
import 'package:moreway/module/place/domain/entity/place.dart';
import 'package:moreway/module/place/presentation/state/bloc/places_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  Widget buildHelloTitle() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Привет, Олег!",
          style: TextStyle(fontSize: 16),
        ),
        Text(
          "Куда отправимся?",
          style: TextStyle(fontSize: 32),
        ),
      ],
    );
  }

  Widget buildSearchBar(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 40,
        maxHeight: 60,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            const Expanded(
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Поиск",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  prefixIcon: Icon(Icons.search),
                  hintStyle: TextStyle(fontSize: 14),
                ),
              ),
            ),
            SizedBox(width: screenSize.width * 0.025),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: AppColor.black),
              child: IconButton(
                icon: const Icon(
                  Icons.tune,
                  color: AppColor.white,
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildLocation() {
    return Row(
      children: [
        const Icon(
          Icons.my_location,
          color: AppColor.pink,
          size: 20.0,
        ),
        const SizedBox(width: 10),
        BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            return Text(
              state.city ?? "Где-то в лесу",
              style: const TextStyle(
                fontSize: 16.0,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildAvatar() {
    return CircleAvatar(
      backgroundColor: AppColor.pink,
      radius: 24,
      child: CircleAvatar(
        radius: 20,
        backgroundImage: Image.network(
                "https://i.pinimg.com/736x/4b/be/6f/4bbe6f4c03ba1b127c3b868c307fc445.jpg")
            .image,
      ),
    );
  }

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
          title: buildLocation(),
          actions: [buildAvatar()],
        ),
        body: BlocListener<PlacesBloc, PlacesState>(
          listener: (context, state) {
            if (state.loadingStatus == LoadingStatus.failure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(buildSnackBar(state.errorMessage!));
            }
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 80,
                flexibleSpace: FlexibleSpaceBar(
                  background: buildHelloTitle(),
                ),
              ),
              SliverAppBar(
                elevation: 0,
                pinned: true,
                backgroundColor: AppColor.white,
                surfaceTintColor: Colors.transparent,
                flexibleSpace:
                    FlexibleSpaceBar(background: buildSearchBar(context)),
              ),
              const SliverAppBar(
                //expandedHeight: 50,
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
                builder: (context, state) {
                  if (state.loadingStatus == LoadingStatus.loading) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state.loadingStatus == LoadingStatus.success) {
                      return SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 16 / 13,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final place = state.places[index % 3];
                            return buildPlaceCard(place);
                          },
                          childCount: state.places.length * 3,
                        ),
                      );
                  } else {
                    return const SliverFillRemaining(
                      child: Center(
                        child:
                            Text('Не удалось загрузить достопримечательности'),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPlaceCard(Place place) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: Image.network(
              "https://i0.wp.com/sunrisedaycamp.org/wp-content/uploads/2020/10/placeholder.png?ssl=1",
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      place.name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 12,
                          color: AppColor.pink,
                        ),
                        const SizedBox(width: 5,),
                        Text(
                          place.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: AppColor.gray,
                            fontSize: 12,
                            fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Icon(
                      Icons.place,
                      color: AppColor.pink,
                      size: 12,
                    ),
                    Text(
                      "${place.distance.toStringAsFixed(1)} км",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColor.gray
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
    /*
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              "https://i0.wp.com/sunrisedaycamp.org/wp-content/uploads/2020/10/placeholder.png?ssl=1",
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${place.distance.toStringAsFixed(1)} км',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      place.rating.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  place.location,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    */
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
