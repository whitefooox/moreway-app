import 'package:flutter/material.dart';
import 'package:moreway/core/theme/colors.dart';

SnackBar buildSnackBar(String message){
  return SnackBar(
    backgroundColor: AppColor.black,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.vertical(
        top: Radius.circular(15),
        bottom: Radius.circular(15)
      )
    ),
    behavior: SnackBarBehavior.floating,
    content: Center(
      child: Text(
        message,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),
      )
    )
  );
}

/*
final SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.horizontal(
          start: Radius.circular(15)
        )
      ),
      content: Text(message),
    );
  }
}
*/