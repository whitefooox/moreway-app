import 'package:flutter/material.dart';
import 'package:moreway/core/const/colors.dart';

class AppFormField extends StatelessWidget {

  final String? labelText;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? textController;

  const AppFormField({
    super.key,
    this.labelText,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.textController
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.black
          )
        ),
        labelStyle: const TextStyle(
          color: AppColor.black
        ),
        suffixIcon: suffixIcon
      ),
      obscureText: obscureText,
      validator: validator,
    );
  }
}