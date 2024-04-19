import 'package:flutter/material.dart';
import 'package:moreway/module/place/domain/entity/place.dart';
import 'package:moreway/core/theme/colors.dart';

class PlaceCard extends StatelessWidget {
  final Place place;

  const PlaceCard({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 130),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: Image.network(
                place.image,
                height: 90,
                fit: BoxFit.cover,
              ),
              // child: Container(
              //   height: 90,
              // ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
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
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.place,
                        color: AppColor.pink,
                        size: 12,
                      ),
                      Text(
                        "${place.distance.toStringAsFixed(1)} км",
                        style:
                            const TextStyle(fontSize: 12, color: AppColor.gray),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
