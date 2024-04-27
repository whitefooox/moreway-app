import 'package:flutter/material.dart';
import 'package:moreway/core/theme/colors.dart';

class CustomSlider extends StatefulWidget {
  final double min;
  final double max;
  final Function(double) onChanged;

  CustomSlider({required this.min, required this.max, required this.onChanged});

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        trackShape: CustomTrackShape(),
        thumbShape: CustomThumbShape(),
      ),
      child: Slider(
        min: widget.min,
        max: widget.max,
        value: _value,
        onChanged: (value) {
          setState(() {
            _value = value;
          });
          widget.onChanged(value);
        },
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 2;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class CustomThumbShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(20, 30);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;
    final flagPaint = Paint()
      ..color = AppColor.black
      ..style = PaintingStyle.fill;

    final polePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawLine(Offset(center.dx, center.dy),
        Offset(center.dx, center.dy - 20), polePaint);
    final path = Path();
    path.moveTo(center.dx, center.dy - 20);
    path.lineTo(center.dx + 10, center.dy - 20);
    path.lineTo(center.dx + 10, center.dy - 10);
    path.lineTo(center.dx, center.dy - 10);
    path.close();
    canvas.drawPath(path, flagPaint);
  }
}
