import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moreway/core/const/assets.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:moreway/module/auth/presentation/bloc/auth_bloc.dart';
import 'package:moreway/module/auth/presentation/validation/auth_validator.dart';
import 'package:moreway/core/snackbar.dart';

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
        name: _nameTextController.text,
        email: _emailTextController.text,
        password: _passwordTextController.text
      ));
    }
  }

  void _changePasswordVisible() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  void _changeConfirmPasswordVisible() {
    setState(() {
      _isHiddenConfirmPassword = !_isHiddenConfirmPassword;
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

  Widget _buildSignInLink(BuildContext context) {
    final theme = Theme.of(context);
    return Wrap(
        children: [
          Text(
            "Уже зарегистрированны? ",
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold
            )
          ),
          GestureDetector(
            onTap: () {
              context.go("/signin");
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
                "Войти в аккаунт",
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
              ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(state.errorMessage!));
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
                    flex: 3,
                    child: Center(
                      child: SizedBox(
                        width: screenSize.width * 0.90,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Регистрация",
                                style: theme.textTheme.headlineMedium!.copyWith(
                                  fontWeight: FontWeight.bold
                                )
                              ),
                              const Spacer(
                                flex: 2,
                              ),
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  label: Text(
                                    "Имя",
                                    style: theme.textTheme.labelLarge,
                                  )
                                ),
                                controller: _nameTextController,
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
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
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
                                textInputAction: TextInputAction.next,
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
                                height: 20,
                              ),
                              TextFormField(
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  label: Text(
                                    "Подтверждение пароля",
                                    style: theme.textTheme.labelLarge,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: _changeConfirmPasswordVisible,
                                    icon: Icon(_isHiddenConfirmPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                                ),
                                controller: _confirmPasswordTextController,
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
                                width: screenSize.width * 0.90,
                                child: BlocBuilder<AuthBloc, AuthState>(
                                  bloc: authBloc,
                                  builder: (context, state) {
                                    final isLoading = state.status == AuthStatus.loading;
                                    return ElevatedButton(
                                        onPressed:  isLoading ? null : () => _clickSignUp(authBloc),
                                        child: isLoading
                                          ? const CircularProgressIndicator(
                                              color: AppColor.white,
                                            )
                                          : Text(
                                              "Создать аккаунт",
                                              style: theme.textTheme.titleMedium!.copyWith(
                                                color: AppColor.white,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ));
                                  },
                                ),
                              ),
                              const Spacer(
                                flex: 3,
                              ),
                              Center(child: _buildSignInLink(context)),
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
