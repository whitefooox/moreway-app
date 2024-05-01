import 'package:moreway/module/place/domain/entity/review.dart';

abstract class IPlaceReviewsRepository {
  Future<List<Review>> getReviews(String id, {String? cursor});
}
