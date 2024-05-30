import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:moreway/module/user/presentation/state/user/user_bloc.dart';
import 'package:moreway/module/user/presentation/view/widget/profile_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late final TabController tabController;

  void _goToSearchUsers() {
    context.go("/profile/search-users");
  }

  void _goToSettings(BuildContext context) {
    context.go("/profile/settings");
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
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
            title: const Text("Профиль"),
            titleSpacing: 0.0,
            centerTitle: false,
            actions: [
              IconButton(
                  onPressed: () => _goToSettings(context),
                  icon: const Icon(
                    Icons.settings,
                    color: AppColor.gray,
                    size: 25,
                  )),
            ],
          ),
          body: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state.loadingStatus == LoadingStatus.success) {
                return Column(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Center(
                            child: ProfileCard(
                          imageUrl: state.user!.avatarUrl,
                          name: state.user!.name,
                          score: state.user!.score,
                        ))),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TabBar(
                            indicatorColor: AppColor.pink,
                            labelColor: AppColor.gray,
                            tabs: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: Text(
                                  "Основное",
                                  style: textTheme.bodyMedium,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: Text(
                                  "Рейтинг",
                                  style: textTheme.bodyMedium,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: Text(
                                  "Друзья",
                                  style: textTheme.bodyMedium,
                                ),
                              ),
                            ],
                            controller: tabController,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TabBarView(
                                  controller: tabController,
                                  children: [
                                    GridView.count(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      children: [
                                        // Добавляем оформление для кнопки "Избранные маршруты"
                                        ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColor.pink,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16, horizontal: 24),
                                            textStyle: textTheme.bodyMedium
                                                ?.copyWith(color: Colors.white),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.favorite,
                                                color: Colors.white,
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                "Избранные маршруты",
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Кнопка "Мои маршруты"
                                        ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16, horizontal: 24),
                                            textStyle: textTheme.bodyMedium,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.route),
                                              SizedBox(height: 8),
                                              Text("Мои маршруты"),
                                            ],
                                          ),
                                        ),
                                        // Кнопка "Мои достижения"
                                        ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColor.black,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16, horizontal: 24),
                                            textStyle: textTheme.bodyMedium,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.star),
                                              SizedBox(height: 8),
                                              Text("Все достижения"),
                                            ],
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColor.pink,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16, horizontal: 24),
                                            textStyle: textTheme.bodyMedium,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.star),
                                              SizedBox(height: 8),
                                              Text("Мои достижения"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Text("Прогресс"),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                                "Хотите добавить друзей?"),
                                            ElevatedButton(
                                                onPressed: _goToSearchUsers,
                                                child: const Text("Найти"))
                                          ],
                                        )
                                      ],
                                    )
                                  ]),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width,
                      height: 60 + screenSize.width * 0.035 * 2,
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
    );
  }
}
