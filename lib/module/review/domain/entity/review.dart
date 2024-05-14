import 'package:moreway/module/user/domain/entity/user_preview.dart';

class Review {
  final String id;
  final String text;
  final double rating;
  final DateTime createdAt;
  final UserPreview userInfo;

  Review(
      {required this.id,
      required this.text,
      required this.createdAt,
      required this.rating,
      required this.userInfo});
}
