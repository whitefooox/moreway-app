import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:moreway/module/auth/presentation/validation/auth_validator.dart';

class EmailForResetPasswordPage extends StatelessWidget {
  EmailForResetPasswordPage({super.key});
  final _emailTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _clickSendCode(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.go("/verify-code");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: LayoutBuilder(
          builder:(context, constraints) => ConstrainedBox(
            constraints: constraints,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.075
              ),
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Забыли пароль?",
                                style: theme.textTheme.headlineMedium!.copyWith(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Не волнуйтесь! Такое бывает. Пожалуйста, введите адрес электронной почты, связанный с вашей учетной записью.",
                                style: theme.textTheme.bodyLarge!.copyWith(
                                  color: AppColor.gray,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.done,
                                  decoration: const InputDecoration(
                                    label: Text(
                                      "Почта"
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
                                  height: 30,
                                ),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(minWidth: double.infinity),
                                  child: ElevatedButton(
                                      onPressed: () => _clickSendCode(context), 
                                      child: Text(
                                        "Отправить код",
                                        style: theme.textTheme.titleMedium!.copyWith(
                                          color: AppColor.white,
                                          fontWeight: FontWeight.bold
                                        ),
                                      )
                                    ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ),
                    const Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Text(
                              "Вспомнили пароль? Войти"
                            ),
                          )
                        ],
                      )
                    ),
                  ],
                ),
            ),
            ),
          ),
        /*
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.075
          ),
          child: SafeArea(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height /2,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Забыли пароль?",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Не переживайте! Такое бывает. Пожалуйста, введите адрес электронной почты, связанный с вашей учетной записью.",
                                  style: TextStyle(
                                    color: AppColor.gray,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.85,
                                  child: ElevatedButton(
                                    onPressed: (){}, 
                                    child: Text(
                                        "Отправить код",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight:
                                          FontWeight.bold
                                        ),
                                      ),
                                    )
                                  ),
                              ],
                            ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("data"),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                        )
                      ],
                    ),
            ),
            ),
            */
      ),
    );
  }
}