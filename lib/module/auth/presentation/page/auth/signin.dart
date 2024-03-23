import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moreway/core/const/assets.dart';
import 'package:moreway/core/theme/colors.dart';
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

  Widget _buildTitle(BuildContext context) {
    final theme = Theme.of(context);
    return Wrap(
      children: [
        Text(
          "More",
          style: theme.textTheme.displaySmall!.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColor.black
          ),
        ),
        Text(
          "Way",
          style: theme.textTheme.displaySmall!.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColor.pink
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpLink(BuildContext context) {
    final theme = Theme.of(context);
    return Wrap(
        children: [
          Text(
            "Не зарегистрированны? ",
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold
            )
          ),
          GestureDetector(
            onTap: () {
              context.go("/signup");
            },
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColor.pink,
                  )
                )
              ),
              child: Text(
                "Создать аккаунт",
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColor.pink,
                )
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
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                        children: [_buildLogo(), _buildTitle(context)])),
                Expanded(
                    flex: 2,
                    child: Center(
                      child: SizedBox(
                        width: screenSize.width * 0.90,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Авторизация",
                                style: theme.textTheme.headlineMedium!.copyWith(
                                  fontWeight: FontWeight.bold
                                )
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  label: Text(
                                    "Почта",
                                    style: theme.textTheme.labelLarge,
                                  )
                                ),
                                controller: _emailTextController,
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
                              TextFormField(
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  label: Text(
                                    "Пароль",
                                    style: theme.textTheme.labelLarge,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: _changePasswordVisible,
                                    icon: Icon(_isHiddenPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                                ),
                                controller: _passwordTextController,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      log("message");
                                      context.push("/signin/reset-password");
                                    } ,
                                    child: Text(
                                      "Забыли пароль?",
                                      style: theme.textTheme.bodyMedium!.copyWith(
                                        color: AppColor.pink,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const Spacer(
                                flex: 2,
                              ),
                              SizedBox(
                                width: screenSize.width * 0.90,
                                child: BlocBuilder<AuthBloc, AuthState>(
                                  bloc: authBloc,
                                  builder: (context, state) {
                                    final isLoading = state.status == AuthStatus.loading;
                                    return ElevatedButton(
                                        onPressed: isLoading ? null : () => _clickSignIn(authBloc),
                                        child: isLoading
                                          ? const CircularProgressIndicator(
                                              color: AppColor.white,
                                            )
                                          : Text(
                                              "Войти",
                                              style: theme.textTheme.titleMedium!.copyWith(
                                                color: AppColor.white,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ));
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
      )),
    );
  }
}
