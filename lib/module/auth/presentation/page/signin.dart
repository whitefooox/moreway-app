import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:moreway/core/const/colors.dart';
import 'package:moreway/core/utils/responsive.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  bool isHiddenPassword = true;

  void changePasswordVisible(){
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  Widget buildTitle(){
    return const Row(
      children: [
        Text(
          "More",
          style: TextStyle(
            fontSize: 14,
            color: AppColor.black,
            fontWeight: FontWeight.w500
          ),
        ),
        Text(
          "Way",
          style: TextStyle(
            fontSize: 14,
            color: AppColor.pink,
            fontWeight: FontWeight.w500
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: buildTitle(),
      ),body: Form(
        child: Center(
          child: SizedBox(
            width: screenSize.width * 0.85,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Spacer(),
                const Text(
                  "Авторизация",
                  style: TextStyle(
                    fontSize: 30,
                    color: AppColor.gray,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const Spacer(flex: 2,),
                const Text(
                  "Добро пожаловать в наше приложение",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 22,),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Введите email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    //prefixIcon: Icon(Icons.email)
                  ),
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Введите пароль",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))
                    ),
                   // prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: changePasswordVisible, 
                      icon: Icon(
                        isHiddenPassword ? Icons.visibility : Icons.visibility_off
                      )
                    )
                  ),
                  obscureText: isHiddenPassword,
                ),
                const SizedBox(height: 10,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Забыли пароль?",
                      style: TextStyle(
                        color: AppColor.pink,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
                const Spacer(flex: 2,),
                SizedBox(
                  width: screenSize.width * 0.85,
                  child: ElevatedButton(
                    onPressed: (){}, 
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 13),
                      child: Text(
                        "Войти",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ),
                ),
                const Spacer(flex: 5,),
                Wrap(
                  children: [
                    Text(
                      "У вас нет аккаунта? ",
                      style: TextStyle(
                        fontSize: 13
                      ),
                    ),
                    Text(
                      "Зарегистрируйтесь сейчас",
                      style: TextStyle(
                        fontSize: 13
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        )
      ),
    );
  }
}