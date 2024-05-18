import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:moreway/module/user/presentation/state/bloc/user_bloc.dart';
import 'package:moreway/module/user/presentation/view/widget/profile_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _goToSettings(BuildContext context){
    context.go("/profile/settings");
  }
  
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
          appBar: AppBar(
            title: const Text("Профиль"),
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
                        flex: 2,
                        child: Center(
                            child: ProfileCard(
                                imageUrl: state.user!.avatarUrl,
                                name: state.user!.name))),
                    Expanded(
                        flex: 3,
                        child: Container(
                          color: Colors.blue,
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.green,
                        )),
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
          )
    );
  }
}
