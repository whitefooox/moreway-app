import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:moreway/module/welcome/presentation/bloc/launch_bloc.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  static const String name = "welcome";
  static const String path = "/welcome";

  static Widget create() {
    return BlocProvider<LaunchBloc>.value(
      value: GetIt.instance.get<LaunchBloc>(),
      child: const WelcomePage(),
    );
  }

  void onClickEnter(BuildContext context) {
    final launchBloc = BlocProvider.of<LaunchBloc>(context);
    launchBloc.add(SetFirstStatusLaunchEvent(false));
    //context.go("/home");
  }

  Widget buildTitle() {
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
                color: AppColor.pink),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Widget buildSlogan() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Много ",
              style: TextStyle(fontSize: 32),
            ),
            Text(
              "путей ",
              style: TextStyle(fontSize: 32, color: AppColor.pink),
            ),
            Text(
              "- ",
              style: TextStyle(fontSize: 32),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "много",
              style: TextStyle(fontSize: 32),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "возможностей",
              style: TextStyle(fontSize: 32, color: AppColor.pink),
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

  Widget buildDescription() {
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
    return BlocListener<LaunchBloc, LaunchState>(
      listener: (context, state) {
        if (state.isFirstLaunch == false) {
          context.go("/home");
        }
      },
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/welcome.jpg"),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Positioned(
                  left: screenSize.width * 0.4,
                  top: screenSize.height * 0.1,
                  width: 200,
                  child: buildTitle()),
              Positioned(
                bottom: 0,
                height: screenSize.height * 0.43,
                width: screenSize.width,
                child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.black, Colors.transparent])),
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: screenSize.width * 0.06,
                            right: screenSize.width * 0.06),
                        child: Container(
                            decoration: const BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(32),
                                )),
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenSize.width * 0.1),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      buildSlogan(),
                                      const SizedBox(height: 10),
                                      buildDescription(),
                                      SizedBox(
                                          height: screenSize.height * 0.05),
                                      SizedBox(
                                        width: screenSize.width * 0.68,
                                        child: ElevatedButton(
                                            onPressed: () =>
                                                onClickEnter(context),
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 13),
                                              child: Text(
                                                "Начать путешествие",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ))))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
