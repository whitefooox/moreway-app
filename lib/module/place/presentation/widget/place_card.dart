import 'package:flutter/material.dart';
import 'package:moreway/module/place/domain/entity/place.dart';
import 'package:moreway/core/theme/colors.dart';

class PlaceCard extends StatelessWidget {
  final Place place;

  const PlaceCard({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              place.image,
              height: 90,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox(
                  height: 90,
                  child: Center(
                    child: Icon(Icons.not_interested),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        place.name,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                          fontFamily: "roboto",
                        ),
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
                        const Icon(
                          Icons.place,
                          color: AppColor.pink,
                          size: 12,
                        ),
                        Text(
                          "${place.distance.toStringAsFixed(1)} км",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.gray),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 12,
                          color: AppColor.pink,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          place.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: AppColor.gray,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
