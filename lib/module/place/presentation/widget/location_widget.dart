import 'package:flutter/material.dart';
import 'package:moreway/core/theme/colors.dart';

class LocationWidget extends StatefulWidget {
  final String? city;

  const LocationWidget({Key? key, this.city}) : super(key: key);

  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant LocationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.city != null && oldWidget.city == null) {
      _animationController.stop();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: widget.city == null ? _animation.value : 1.0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColor.pink.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.place,
                  color: AppColor.pink,
                  size: 20.0,
                ),
                const SizedBox(width: 8),
                widget.city != null
                    ? Text(
                        widget.city!,
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      )
                    : const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(AppColor.pink),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
