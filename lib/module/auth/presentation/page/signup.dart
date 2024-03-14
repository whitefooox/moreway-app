import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moreway/core/const/assets.dart';
import 'package:moreway/core/const/colors.dart';
import 'package:moreway/core/widget/app_form_field.dart';
import 'package:moreway/module/auth/presentation/bloc/auth_bloc.dart';
import 'package:moreway/module/auth/presentation/validation/auth_validator.dart';
import 'package:moreway/module/auth/presentation/widget/auth_snackbar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isHiddenPassword = true;
  bool _isHiddenConfirmPassword = true;
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();

  void _clickSignUp(AuthBloc authBloc) {
    if (_formKey.currentState!.validate()) {
      authBloc.add(AuthSignUpEvent(
          email: _emailTextController.text,
          password: _passwordTextController.text));
    }
  }

  void changePasswordVisible() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  void changeConfirmPasswordVisible() {
    setState(() {
      _isHiddenConfirmPassword = !_isHiddenConfirmPassword;
    });
  }

  Widget buildLogo() {
    return Image.asset(
      Assets.logoImage,
      width: 80,
    );
  }

  Widget buildTitle() {
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

  Widget buildSignInLink(BuildContext context) {
    return Wrap(
        children: [
          const Text(
            "Уже зарегистрированны? ",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: AppColor.pink,
            ))),
            child: GestureDetector(
              onTap: () => context.go("/signin"),
              child: const Text(
                "Войти в аккаунт",
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
                      children: [buildLogo(), buildTitle()])),
              Expanded(
                  flex: 3,
                  child: Center(
                    child: SizedBox(
                      width: screenSize.width * 0.85,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Регистрация",
                              style: TextStyle(
                                  fontSize: 32,
                                  color: AppColor.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Spacer(
                              flex: 2,
                            ),
                            AppFormField(
                              labelText: "Имя",
                              textController: _nameTextController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Нужно имя";
                                } else if(!AuthValidator.isUsernameValid(value)){
                                  return "Допустимы только буквы и цифры";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
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
                                  onPressed: changePasswordVisible,
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
                              height: 20,
                            ),
                            AppFormField(
                              labelText: "Подтверждение пароля",
                              textController: _confirmPasswordTextController,
                              suffixIcon: IconButton(
                                  onPressed: changeConfirmPasswordVisible,
                                  icon: Icon(_isHiddenConfirmPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                              obscureText: _isHiddenConfirmPassword,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Нужен пароль";
                                } else if (!AuthValidator.isPasswordValid(
                                    value)) {
                                  return "Не менее 8 символов";
                                } else if(
                                  _passwordTextController.text != _confirmPasswordTextController.text
                                ) {
                                  return "Пароли не совпадают";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const Spacer(
                              flex: 2,
                            ),
                            SizedBox(
                              width: screenSize.width * 0.85,
                              child: BlocBuilder<AuthBloc, AuthState>(
                                bloc: authBloc,
                                builder: (context, state) {
                                  return ElevatedButton(
                                      onPressed: () => _clickSignUp(authBloc),
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 13),
                                          child: (state.status ==
                                                  AuthStatus.loading)
                                              ? const CircularProgressIndicator(
                                                  color: AppColor.white,
                                                )
                                              : const Text(
                                                  "Создать аккаунт",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )));
                                },
                              ),
                            ),
                            const Spacer(
                              flex: 3,
                            ),
                            Center(child: buildSignInLink(context)),
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
