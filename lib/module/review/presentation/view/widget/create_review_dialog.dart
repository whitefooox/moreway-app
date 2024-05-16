import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:moreway/module/review/domain/entity/review_raw.dart';

Future<ReviewRaw?> showCreateReviewDialog(BuildContext context) async {
  double rating = 5;
  String reviewText = '';

  return await showDialog<ReviewRaw>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Оставьте отзыв'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RatingBar.builder(
              initialRating: 5,
              minRating: 0,
              direction: Axis.horizontal,
              itemCount: 5,
              itemSize: 30,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: AppColor.pink,
              ),
              onRatingUpdate: (value) {
                rating = value;
              },
            ),
            const SizedBox(height: 10),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Напишите здесь...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                reviewText = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              final review = ReviewRaw(rating: rating, text: reviewText);
              Navigator.of(context).pop(review);
            },
            child: const Text('Отправить'),
          ),
        ],
      );
    },
  );
}
