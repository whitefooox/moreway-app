import 'package:flutter/material.dart';

class DashedVerticalLine extends StatelessWidget {
  final double height;
  final double dashWidth;
  final double dashHeight;
  final double dashSpace;
  final Color color;

  const DashedVerticalLine({
    Key? key,
    this.height = 100,
    this.dashWidth = 1,
    this.dashHeight = 5,
    this.dashSpace = 5,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: CustomPaint(
        painter: _DashedVerticalLinePainter(
          dashWidth: dashWidth,
          dashHeight: dashHeight,
          dashSpace: dashSpace,
          color: color,
        ),
      ),
    );
  }
}

class _DashedVerticalLinePainter extends CustomPainter {
  final double dashWidth;
  final double dashHeight;
  final double dashSpace;
  final Color color;

  _DashedVerticalLinePainter({
    required this.dashWidth,
    required this.dashHeight,
    required this.dashSpace,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double startY = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = dashWidth;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(_DashedVerticalLinePainter oldDelegate) =>
      dashWidth != oldDelegate.dashWidth ||
      dashHeight != oldDelegate.dashHeight ||
      dashSpace != oldDelegate.dashSpace ||
      color != oldDelegate.color;
}