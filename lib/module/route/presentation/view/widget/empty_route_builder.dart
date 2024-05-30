import 'package:flutter/material.dart';
import 'package:moreway/core/const/assets.dart';

class EmptyRouteBuilder extends StatelessWidget {
  const EmptyRouteBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(Assets.panelIconImage, height: 50),
          SizedBox(height: 24),
          Text(
            "Здесь пусто!",
            style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold)
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              "Начните добавлять интересные места, чтобы спланировать свое путешествие.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }
}