import 'package:flutter/material.dart';
import 'package:moreway/core/theme/colors.dart';

class EmailForResetPasswordPage extends StatelessWidget {
  const EmailForResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
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
    );
  }
}