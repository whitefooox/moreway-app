import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moreway/core/utils/colors.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          //type: BottomNavigationBarType.fixed,
          //showSelectedLabels: false,
          //showUnselectedLabels: false,
          /*
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "home"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.route), label: "route"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.place), label: "map"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message_sharp), label: "message"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "profile"
            ),
          ]
          */
      body: Stack(
        children: [
          ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return ListTile(title: Text(index.toString()),);
          }
        ),
        Positioned(
          bottom: 15,
          left: 5,
          right: 5,
          child: SizedBox(
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(icon: SvgPicture.asset("assets/icons/home_icon.svg"), label: "home"),
                  BottomNavigationBarItem(icon: Icon(Icons.route), label: "route"),
                  BottomNavigationBarItem(icon: Icon(Icons.place), label: "place"),
                  BottomNavigationBarItem(icon: Icon(Icons.chat_rounded), label: "chat"),
                  BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "account")
                ]
              ),
            ),
          )
        )
        ]
      ),
    );
  }

}