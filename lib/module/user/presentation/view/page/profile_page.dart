import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:moreway/module/auth/presentation/bloc/auth_bloc.dart';
import 'package:moreway/module/user/presentation/view/widget/profile_card.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          left: screenSize.width * 0.035,
          right: screenSize.width * 0.035,
          top: screenSize.height * 0.01),
      child: Scaffold(
          appBar: AppBar(
            title: Text("Профиль"),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.settings,
                    color: AppColor.gray,
                    size: 25,
                  )),
            ],
          ),
          body: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: Center(
                        child: ProfileCard(imageUrl: state.user!.avatarUrl, name: state.user!.name)
                      )),
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
            },
          )),
    );
  }
}
