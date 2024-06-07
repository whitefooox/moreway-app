import 'dart:math';

import 'package:flutter/material.dart';

class SquareWidget extends StatelessWidget {
  final Widget child;

  const SquareWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final minDimension = min(constraints.maxWidth, constraints.maxHeight);
        return SizedBox(
          width: minDimension,
          height: minDimension,
          child: child,
        );
      },
    );
  }
}