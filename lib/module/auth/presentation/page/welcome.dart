import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moreway/core/utils/colors.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  void onClickEnter(BuildContext context){
    context.go("/home");
  }

  Widget buildTitle(){
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: const Text(
            "More",
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w500,
              height: 1.1,
              color: AppColor.black,
              //backgroundColor: Colors.white
            ),
            textAlign: TextAlign.start,
          ),
        ),
        Container(
          alignment: Alignment.bottomRight,
          child: const Text(
            "Way",
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w500,
              height: 1.1,
              color: AppColor.pink
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Widget buildSlogan(){
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Много ",
              style: TextStyle(
                fontSize: 32
              ),
            ),
            Text(
              "путей ",
              style: TextStyle(
                fontSize: 32,
                color: AppColor.pink
              ),
            ),
            Text(
              "- ",
              style: TextStyle(
                fontSize: 32
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "много",
              style: TextStyle(
                fontSize: 32
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "возможностей",
              style: TextStyle(
                fontSize: 32,
                color: AppColor.pink
              ),
            ),
            Text(
              "!",
              style: TextStyle(
                fontSize: 32,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDescription(){
    return const Text(
      "Исследуй родной регион вместе с друзьями.",
      style: TextStyle(
        fontSize: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/welcome.jpg"),
          fit: BoxFit.cover
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              left: screenSize.width * 0.4,
              top: screenSize.height * 0.1,
              width: 200,
              child: buildTitle()
            ),
            Positioned(
              bottom: 0,
              height: screenSize.height * 0.43,
              width: screenSize.width,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black,
                      Colors.transparent
                    ]
                  )
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: screenSize.width * 0.06,
                    right: screenSize.width * 0.06
                  ),
                  child: LayoutBuilder(
                    builder: (layoutContext, constraints) => Container(
                      decoration: const BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32)
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: constraints.maxWidth * 0.1,//screenSize.width * 0.08,
                          right: constraints.maxWidth * 0.1,//screenSize.width * 0.08,
                          //top: constraints.maxWidth * 0.05,
                        ),
                        child: Expanded(
                            //width: constraints.maxWidth,
                            //height: constraints.maxHeight,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  buildSlogan(),
                                  const SizedBox(height: 10),
                                  buildDescription(),
                                  SizedBox(height: constraints.maxHeight * 0.14),
                                  SizedBox(
                                    width: constraints.maxWidth * 0.65,//screenSize.width * 0.88 * 4 / 6,
                                    height: constraints.maxHeight * 0.14,//screenSize.width * 0.88 / 6,
                                    child: ElevatedButton(
                                      onPressed: () => onClickEnter(context), 
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        foregroundColor: AppColor.white,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                      ),
                                      child: const Text(
                                        "Войти",
                                        style: TextStyle(
                                          fontSize: 20
                                        ),
                                      )
                                    ),
                              ),
                                ],
                              ),
                            )
                          )
                        )
                      )
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}