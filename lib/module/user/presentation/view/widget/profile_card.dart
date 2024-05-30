import 'package:flutter/material.dart';
import 'package:moreway/core/theme/colors.dart';

class ProfileCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int score;

  const ProfileCard(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.score});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 50,
              child: ClipOval(
                child: Image.network(
                  imageUrl,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.not_interested);
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 5, // Отступ снизу для лучшей адаптивности
              right: 5,  // Отступ справа для лучшей адаптивности
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 5, horizontal: 8), // Изменили горизонтальный padding
                decoration: BoxDecoration(
                  color: AppColor.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      color: AppColor.white,
                      size: textTheme.labelMedium!.fontSize! * 0.8, // Уменьшили размер иконки
                    ),
                    const SizedBox(
                      width: 3, // Уменьшили размер SizedBox
                    ),
                    Text(
                      '$score',
                      style: textTheme.labelMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColor.white,
                          fontSize: textTheme.labelMedium!.fontSize! * 0.8), // Уменьшили размер текста
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(name,
            style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
