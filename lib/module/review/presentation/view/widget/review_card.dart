import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:moreway/module/review/domain/entity/review.dart';
import 'package:readmore/readmore.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard(
      {super.key,
      required this.review});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    String formattedDate = "${review.createdAt.day}.${review.createdAt.month}.${review.createdAt.year}";

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(review.userInfo.avatarUrl),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review.userInfo.name,
                              style: textTheme.titleMedium,
                            ),
                            RatingBarIndicator(
                              rating: review.rating,
                              itemSize: 20,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return const Icon(
                                  Icons.star,
                                  color: AppColor.pink,
                                );
                              },
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                Text(formattedDate)
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            ReadMoreText(
              review.text,
              trimExpandedText: " Скрыть",
              trimCollapsedText: "Читать дальше",
              colorClickableText: AppColor.pink,
            )
          ],
        ),
      ),
    );
  }
}
