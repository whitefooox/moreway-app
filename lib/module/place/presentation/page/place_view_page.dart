import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlaceViewPage extends StatelessWidget {
  const PlaceViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      // ),
      // appBar: PreferredSize(
      //     preferredSize: Size(screenSize.width, 40),
      //     child: Container(
      //       color: Colors.green,
      //     )),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: screenSize.width,
                height: screenSize.width,
                color: Colors.red,
              ),
              Expanded(
                child: Container(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          Positioned(
              //top: 10,
              child: SafeArea(
                  child: AppBar(
            backgroundColor: Colors.transparent,
          ))),
        ],
      ),
    );
  }
}
