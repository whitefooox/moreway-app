import 'package:flutter/material.dart';
import 'package:moreway/core/theme/colors.dart';

SnackBar buildSnackBar(String message) {
  return SnackBar(
      backgroundColor: AppColor.black,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.vertical(
              top: Radius.circular(15), bottom: Radius.circular(15))),
      behavior: SnackBarBehavior.floating,
      content: Center(
          child: Text(
        message,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      )));
}

SnackBar buildSuccessSnackbar(String message) {
  return SnackBar(
      backgroundColor: AppColor.black,
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.vertical(
              top: Radius.circular(15), bottom: Radius.circular(15))),
      content: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              width: 5,
            ),
            const Icon(
              Icons.check,
              color: Colors.white,
            )
          ],
        ),
      ));
}

SnackBar buildFailureSnackbar(String message) {
  return SnackBar(
      backgroundColor: AppColor.pink,
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.vertical(
              top: Radius.circular(15), bottom: Radius.circular(15))),
      content: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              width: 5,
            ),
            const Icon(
              Icons.close,
              color: Colors.white,
            )
          ],
        ),
      ));
}
