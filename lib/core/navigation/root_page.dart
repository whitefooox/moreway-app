import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moreway/core/theme/colors.dart';

class RootPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const RootPage({
    super.key,
    required this.navigationShell
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: 
      Stack(
        children: [
          navigationShell,
          Positioned(
            bottom: screenSize.width * 0.02,
            left: screenSize.width * 0.02,
            right: screenSize.width * 0.02,
            child: SizedBox(
              height: 80,
              child: ClipRRect(
                borderRadius: const BorderRadius.all( Radius.circular(15)),
                child: BottomNavigationBar(
                  currentIndex: navigationShell.currentIndex,
                  items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
                    BottomNavigationBarItem(icon: Icon(Icons.route), label: "route"),
                    BottomNavigationBarItem(icon: Icon(Icons.place), label: "place"),
                    BottomNavigationBarItem(icon: Icon(Icons.chat_rounded), label: "chat"),
                    BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "account")
                  ],
                  onTap: (index) => navigationShell.goBranch(
                    index,
                    initialLocation: index == navigationShell.currentIndex,
                  ),
                ),
              ),
            )
          )
        ]
      ),
    );
  }

}