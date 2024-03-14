import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moreway/core/const/assets.dart';
import 'package:moreway/core/const/colors.dart';
import 'package:moreway/core/widget/app_form_field.dart';
import 'package:moreway/module/auth/presentation/bloc/auth_bloc.dart';
import 'package:moreway/module/auth/presentation/validation/auth_validator.dart';
import 'package:moreway/module/auth/presentation/widget/auth_snackbar.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isHiddenPassword = true;
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  void _clickSignIn(AuthBloc authBloc) {
    if (_formKey.currentState!.validate()) {
      authBloc.add(AuthSignInEvent(
          email: _emailTextController.text,
          password: _passwordTextController.text));
    }
  }

  void _changePasswordVisible() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  Widget _buildLogo() {
    return Image.asset(
      Assets.logoImage,
      width: 80,
    );
  }

  Widget _buildTitle() {
    return const Wrap(
      children: [
        Text(
          "More",
          style: TextStyle(
              fontSize: 36, color: AppColor.black, fontWeight: FontWeight.w500),
        ),
        Text(
          "Way",
          style: TextStyle(
              fontSize: 36, color: AppColor.pink, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildSignUpLink(BuildContext context) {
    return Wrap(
        children: [
          const Text(
            "Не зарегистрированны? ",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: AppColor.pink,
            ))),
            child: GestureDetector(
              onTap: () {
                log("go to sign up page");
                context.go("/signup");
              },
              child: const Text(
                "Создать аккаунт",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColor.pink,
                ),
              ),
            ),
          ),
        ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final authBloc = context.read<AuthBloc>();

    return Scaffold(
        body: SingleChildScrollView(
      child: BlocListener<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          if(state.status == AuthStatus.failure){
            ScaffoldMessenger.of(context).showSnackBar(buildAuthSnackBar(state.errorMessage!));
          } else if(state.status == AuthStatus.authorized){
            ScaffoldMessenger.of(context).clearSnackBars();
            context.go("/home");
          }
        },
        child: SizedBox(
          height: screenSize.height,
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [_buildLogo(), _buildTitle()])),
              Expanded(
                  flex: 2,
                  child: Center(
                    child: SizedBox(
                      width: screenSize.width * 0.85,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Авторизация",
                              style: TextStyle(
                                  fontSize: 32,
                                  color: AppColor.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            AppFormField(
                              labelText: "Почта",
                              textController: _emailTextController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Нужна почта";
                                } else if (!AuthValidator.isEmailValid(value)) {
                                  return "Введите правильную почту";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            AppFormField(
                              labelText: "Пароль",
                              textController: _passwordTextController,
                              suffixIcon: IconButton(
                                  onPressed: _changePasswordVisible,
                                  icon: Icon(_isHiddenPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                              obscureText: _isHiddenPassword,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Нужен пароль";
                                } else if (!AuthValidator.isPasswordValid(
                                    value)) {
                                  return "Не менее 8 символов";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Забыли пароль?",
                                  style: TextStyle(
                                      color: AppColor.pink,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            const Spacer(
                              flex: 2,
                            ),
                            SizedBox(
                              width: screenSize.width * 0.85,
                              child: BlocBuilder<AuthBloc, AuthState>(
                                bloc: authBloc,
                                builder: (context, state) {
                                  final isLoading = state.status == AuthStatus.loading;
                                  return ElevatedButton(
                                      onPressed: isLoading ? null : () => _clickSignIn(authBloc),
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 13),
                                          child: isLoading
                                              ? const CircularProgressIndicator(
                                                  color: AppColor.white,
                                                )
                                              : const Text(
                                                  "Войти",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )));
                                },
                              ),
                            ),
                            const Spacer(
                              flex: 6,
                            ),
                            Center(child: _buildSignUpLink(context)),
                            const Spacer(
                              flex: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    ));
  }
}
