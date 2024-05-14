import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:readmore/readmore.dart';

class ReviewCard extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final DateTime date;
  final double rating;
  final String text;

  const ReviewCard(
      {super.key,
      required this.avatarUrl,
      required this.name,
      required this.date,
      required this.rating,
      required this.text});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    String formattedDate = "${date.day}.${date.month}.${date.year}";

    return Card(
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(avatarUrl),
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
                              name,
                              style: textTheme.titleMedium,
                            ),
                            RatingBarIndicator(
                              rating: rating,
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
              text,
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
