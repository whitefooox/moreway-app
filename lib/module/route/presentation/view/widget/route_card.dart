import 'package:flutter/material.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:moreway/module/route/domain/entity/route.dart' as domain;
import 'package:moreway/module/route/presentation/view/widget/dynamic_image_grid.dart';

class RouteCard extends StatelessWidget {
  final domain.Route route;

  const RouteCard({Key? key, required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final images = route.points
        .map(
          (e) => e.image,
        )
        .toList();
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: DynamicImageGrid(imageUrls: images)),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  route.name,
                  style: textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: "roboto",
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1, // Ограничиваем текст одной строкой
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: NetworkImage(route.creator.avatarUrl),
                      backgroundColor: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      route.creator.name,
                      style:
                          textTheme.bodySmall!.copyWith(color: AppColor.gray),
                      maxLines: 1, // Ограничиваем текст одной строкой
                      overflow: TextOverflow
                          .ellipsis, // Обрезаем текст, если он не помещается
                    ),
                    const Spacer(),
                    Icon(
                      Icons.star,
                      size: textTheme.bodySmall!.fontSize,
                      color: AppColor.pink,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      route.rating.toStringAsFixed(1),
                      style:
                          textTheme.bodySmall!.copyWith(color: AppColor.gray),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}





