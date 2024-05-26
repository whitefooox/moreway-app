import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moreway/core/theme/colors.dart';
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
                          const BottomNavigationBarItem(
                              icon: Icon(Icons.home), label: "home"),
                          BottomNavigationBarItem(
                              icon: Badge(
                                isLabelVisible: state.placesCount != 0,
                                backgroundColor: AppColor.pink,
                                textColor: AppColor.white,
                                label: Text(state.placesCount.toString()),
                                child: const Icon(Icons.route),
                              ),
                              label: "route"),
                          const BottomNavigationBarItem(
                              icon: Icon(Icons.place), label: "place"),
                          const BottomNavigationBarItem(
                              icon: Icon(Icons.chat_rounded), label: "chat"),
                          const BottomNavigationBarItem(
                              icon: Icon(Icons.account_circle),
                              label: "account")
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
