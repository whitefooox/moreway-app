import 'package:flutter/material.dart';
import 'package:moreway/core/theme/colors.dart';

class RouteProgressBar extends StatelessWidget {
  final int currentProgress;
  final int maxProgress;

  const RouteProgressBar({
    super.key,
    required this.currentProgress,
    required this.maxProgress,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 40),
      painter: RouteProgressBarPainter(
        currentProgress: currentProgress,
        maxProgress: maxProgress,
      ),
    );
  }
}

class RouteProgressBarPainter extends CustomPainter {
  final int currentProgress;
  final int maxProgress;

  const RouteProgressBarPainter({
    required this.currentProgress,
    required this.maxProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const int radius = 5;

    final paint = Paint()
      ..color = AppColor.gray
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    final activePaint = Paint()
      ..color = AppColor.pink
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(const Offset(0, 0), Offset(size.width, 0), paint);

    if (currentProgress > 1) {
      canvas.drawLine(
          const Offset(0, 0),
          Offset(size.width / (maxProgress - 1) * (currentProgress - 1), 0),
          activePaint);
    } else {
      if (currentProgress == 1) {
        canvas.drawLine(
            const Offset(radius * 2, 0), const Offset(0, 0), activePaint);
      }
    }

    for (var i = 0; i < maxProgress; i++) {
      final x = size.width / (maxProgress - 1) * i;
      final pointPaint = i < currentProgress ? activePaint : paint;
      if (i == 0) {
        canvas.drawCircle(
            Offset(x + radius, 20), radius.toDouble(), pointPaint);
      } else if (i == maxProgress - 1) {
        const icon = Icons.flag;
        TextPainter textPainter = TextPainter(
          textDirection: TextDirection.rtl,
        );
        textPainter.text = TextSpan(
            text: String.fromCharCode(icon.codePoint),
            style: TextStyle(
                fontSize: radius * 4,
                fontFamily: icon.fontFamily,
                color: i < currentProgress ? AppColor.pink : AppColor.gray));
        textPainter.layout();
        textPainter.paint(canvas, Offset(x - radius * 2, 10));
      } else {
        canvas.drawCircle(Offset(x, 20), radius.toDouble(), pointPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}