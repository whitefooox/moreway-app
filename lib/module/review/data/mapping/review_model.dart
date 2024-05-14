import 'package:json_annotation/json_annotation.dart';
import 'package:moreway/module/review/domain/entity/review.dart';

import 'package:moreway/module/user/data/mapping/user_preview_model.dart';

part 'review_model.g.dart';

@JsonSerializable()
class ReviewModel {
  final int id;
  final String text;
  final double rating;
  final DateTime createdAt;
  final UserPreviewModel author;

  ReviewModel({
    required this.id,
    required this.text,
    required this.rating,
    required this.createdAt,
    required this.author,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);

  Review toReview(){
    return Review(id: id.toString(), text: text, createdAt: createdAt, rating: rating, userInfo: author.toUserPreview());
  }
}
