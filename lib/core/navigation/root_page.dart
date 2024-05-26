import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moreway/module/route/presentation/state/builder/route_builder_bloc.dart';

class RootPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const RootPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          navigationShell,
          Positioned(
              bottom: 0,
              child: Container(
                width: screenSize.width,
                height: screenSize.width * 0.035 + 60,
                decoration: const BoxDecoration(gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    //stops: [0.0, 0.5],
                    colors: [Colors.grey, Colors.transparent])),
              )),
          Positioned(
              bottom: screenSize.width * 0.035,
              left: screenSize.width * 0.035,
              right: screenSize.width * 0.035,
              child: SizedBox(
                height: 60,
                child: BlocBuilder<RouteBuilderBloc, RouteBuilderState>(
                  builder: (context, state) {
                    return ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      child: BottomNavigationBar(
                        currentIndex: navigationShell.currentIndex,
                        items: [
                          BottomNavigationBarItem(
                            icon: Icon(navigationShell.currentIndex == 0
                                ? Icons.home
                                : Icons.home_outlined),
                            label: "home",
                          ),
                          BottomNavigationBarItem(
                            icon: Badge(
                              isLabelVisible: state.placesCount != 0,
                              label: Text(state.placesCount.toString()),
                              child: Icon(navigationShell.currentIndex == 1
                                  ? Icons.route
                                  : Icons.route_outlined),
                            ),
                            label: "route",
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(navigationShell.currentIndex == 2
                                ? Icons.place
                                : Icons.place_outlined),
                            label: "place",
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(navigationShell.currentIndex == 3
                                ? Icons.chat_rounded
                                : Icons.chat_bubble_outline_rounded),
                            label: "chat",
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(navigationShell.currentIndex == 4
                                ? Icons.account_circle
                                : Icons.account_circle_outlined),
                            label: "account",
                          ),
                        ],
                        onTap: (index) => navigationShell.goBranch(
                          index,
                          initialLocation:
                              index == navigationShell.currentIndex,
                        ),
                      ),
                    );
                  },
                ),
              ))
        ]),
      ),
    );
  }
}
