import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moreway/core/const/assets.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:moreway/module/welcome/presentation/bloc/launch_bloc.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  Widget _buildTitle() {
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
          ),
        ),
      ],
    );
  }

  void _onClickEnter(BuildContext context) {
    final launchBloc = BlocProvider.of<LaunchBloc>(context);
    launchBloc.add(SetFirstStatusLaunchEvent(false));
    //context.go("/home");
  }

  Widget _buildSlogan() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text.rich(
          TextSpan(
            style: TextStyle(fontSize: 32),
            children: [
              TextSpan(text: "Много "),
              TextSpan(
                text: "путей ",
                style: TextStyle(color: AppColor.pink),
              ),
              TextSpan(text: "- "),
            ],
          ),
        ),
        Text(
          "много",
          style: TextStyle(fontSize: 32),
        ),
        Text.rich(
          TextSpan(
            style: TextStyle(fontSize: 32),
            children: [
              TextSpan(
                text: "возможностей",
                style: TextStyle(color: AppColor.pink),
              ),
              TextSpan(text: "!"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
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
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.welcomeBackgroundImage),
                  fit: BoxFit.cover)),
          child: Stack(
            children: [
              Positioned(
                  left: screenSize.width * 0.4,
                  top: screenSize.height * 0.1,
                  width: 200,
                  child: _buildTitle()),
              Positioned(
                  bottom: 0,
                  child: Container(
                    height: screenSize.height * 0.43,
                    width: screenSize.width,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.black, Colors.transparent])),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.06),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(32),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildSlogan(),
                                const Spacer(),
                                _buildDescription(),
                                const Spacer(),
                                FractionallySizedBox(
                                  widthFactor: 0.8,
                                  child: ElevatedButton(
                                      onPressed: () => _onClickEnter(context),
                                      child: const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 13),
                                        child: Text(
                                          "Начать путешествие",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
