import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moreway/core/theme/colors.dart';

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
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(32),
                        )
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.1),
                        child: Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  buildSlogan(),
                                  const SizedBox(height: 10),
                                  buildDescription(),
                                  SizedBox(height: constraints.maxHeight * 0.14),
                                  SizedBox(
                                    width: constraints.maxWidth * 0.74,
                                    child: ElevatedButton(
                                      onPressed: () => onClickEnter(context), 
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 13),
                                        child: Text(
                                          "Начать путешествие",
                                          style: TextStyle(
                                            fontSize: 20
                                          ),
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