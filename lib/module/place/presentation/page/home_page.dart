
import 'package:flutter/material.dart';
import 'package:moreway/core/theme/colors.dart';

class HomePage extends StatefulWidget  {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  Widget buildHelloTitle(){
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Привет, Олег!",
          style: TextStyle(
            fontSize: 16
          ),
        ),
        Text(
          "Куда отправимся?",
          style: TextStyle(
            fontSize: 32
          ),
        ),
      ],
    );
  }

  Widget buildSearchBar(BuildContext context){
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
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      prefixIcon: Icon(
                        Icons.search
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14
                      ),
                    ),
                ),
              ),
              SizedBox(width: screenSize.width * 0.025),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: AppColor.black
                ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.tune,
                      color: AppColor.white,
                    ),
                    onPressed: (){
                      
                    },
                  ),
                )
            ],
          ),
        ),
    );
  }

  Widget buildLocation(){
    return const Row(
      children: [
        Icon(
          Icons.my_location,
          color: AppColor.pink,
          size: 20.0, 
        ),
        SizedBox(width: 10),
        Text(
          "Кемерово",
          style: TextStyle(
            fontSize: 16.0, 
          ),
        ),
      ],
    );
  }

  Widget buildAvatar(){
    return CircleAvatar(
      backgroundColor: AppColor.pink,
      radius: 24,
      child: CircleAvatar(
        radius: 20, 
        backgroundImage: Image.network("https://i.pinimg.com/736x/4b/be/6f/4bbe6f4c03ba1b127c3b868c307fc445.jpg").image,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        left: screenSize.width * 0.05,
        right: screenSize.width * 0.05,
        top: screenSize.height * 0.01
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          titleSpacing: 0.0,
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: buildLocation(),
          actions: [
            buildAvatar()
          ],
          ),
          body: CustomScrollView(
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
                flexibleSpace: FlexibleSpaceBar(
                  background: buildSearchBar(context)
                ),
              ),
              SliverAppBar(
                expandedHeight: 100,
                elevation: 0,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                                  const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryChip(label: "Места"),
                    SizedBox(width: 10),
                    CategoryChip(label: "Маршруты"),
                  ],
                ),
            ),
            SizedBox(width: screenSize.width * 0.025),
            const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryChip(label: "Все"),
                    SizedBox(width: 10),
                    CategoryChip(label: "Популярные"),
                    SizedBox(width: 10),
                    CategoryChip(label: "Лучшие"),
                    SizedBox(width: 10),
                    CategoryChip(label: "Новые"),
                    SizedBox(width: 10),
                    CategoryChip(label: "Ближайшие"),
                  ],
                ),
            ),
                    ],
                  )
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.blue,
                        width: 100,
                        height: 100,
                      ),
                    );
                  },
                  childCount: 20
                ),
              )
            ],
          ),
          /*
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Привет, Олег!",
              style: TextStyle(
                fontSize: 16
              ),
            ),
            const Text(
              "Куда отправимся?",
              style: TextStyle(
                fontSize: 32
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenSize.width * 0.025),
              child: ConstrainedBox(
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
                                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                  prefixIcon: Icon(
                                    Icons.search
                                  ),
                                  hintStyle: TextStyle(
                                    fontSize: 14
                                  ),
                                ),
                            ),
                          ),
                          SizedBox(width: screenSize.width * 0.025),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              color: Colors.black
                            ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.tune,
                                  color: Colors.white,
                                ),
                                onPressed: (){
                                  
                                },
                              ),
                            )
                        ],
                      ),
                ),
              ),
            ),
            const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryChip(label: "Места"),
                    SizedBox(width: 10),
                    CategoryChip(label: "Маршруты"),
                  ],
                ),
            ),
            SizedBox(width: screenSize.width * 0.025),
            const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryChip(label: "Все"),
                    SizedBox(width: 10),
                    CategoryChip(label: "Популярные"),
                    SizedBox(width: 10),
                    CategoryChip(label: "Лучшие"),
                    SizedBox(width: 10),
                    CategoryChip(label: "Новые"),
                    SizedBox(width: 10),
                    CategoryChip(label: "Ближайшие"),
                  ],
                ),
            ),
            SizedBox(width: screenSize.width * 0.025),
            Expanded(
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  /*
                  return Attraction1Card(
                    imageUrl: "https://www.xn----7sb3anndnfd.xn--p1ai/sites/default/files/photo/tomskaya_00009.jpg", 
                    name: "Томская Писаница", 
                    rating: 3, 
                    distance: 2583.2
                  );
                  */
                  return SizedBox(
                    height: 100,
                    child: Card(
                      color: AppColor.white,
                      shadowColor: AppColor.white,
                      surfaceTintColor: AppColor.white,
                      //color: Colors.red,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                "https://www.xn----7sb3anndnfd.xn--p1ai/sites/default/files/photo/tomskaya_00009.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Томская писаница",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    ),
                  );
                }
              ),
            )
          ],
        ),
        */
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