import 'package:json_annotation/json_annotation.dart';
import 'package:moreway/core/api/paginated_page.dart';

import 'package:moreway/module/review/data/mapping/review_model.dart';
import 'package:moreway/module/review/domain/entity/review.dart';

part 'review_page_model.g.dart';

@JsonSerializable()
class ReviewPageModel {
  final List<ReviewModel> data;

  @JsonKey(name: "meta", fromJson: _cursorFromJson)
  final String? cursor;

  ReviewPageModel({
    required this.data,
    this.cursor,
  });

  static String? _cursorFromJson(Map<String, dynamic> json) {
    return json["cursor"] as String?;
  }

  factory ReviewPageModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewPageModelToJson(this);

  PaginatedPage<Review> toReviewPage() {
    return PaginatedPage(
        items: data.map((e) => e.toReview()).toList(), cursor: cursor);
  }
}
