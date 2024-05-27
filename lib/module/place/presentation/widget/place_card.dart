import 'package:flutter/material.dart';
import 'package:moreway/module/place/domain/entity/place.dart';
import 'package:moreway/core/theme/colors.dart';

class PlaceCard extends StatelessWidget {
  final Place place;

  const PlaceCard({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: Image.network(
                place.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    child: Center(
                      child: Icon(Icons.not_interested),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        place.name,
                        style: textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: "roboto",
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.place,
                          color: AppColor.pink,
                          size: textTheme.bodySmall!.fontSize,
                        ),
                        Text(
                          "${place.distance.toStringAsFixed(1)} км",
                          style: textTheme.bodySmall!
                              .copyWith(color: AppColor.gray),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: textTheme.bodySmall!.fontSize,
                          color: AppColor.pink,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          place.rating.toStringAsFixed(1),
                          style: textTheme.bodySmall!
                              .copyWith(color: AppColor.gray),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
