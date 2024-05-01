import 'package:moreway/module/place/domain/dependency/i_place_reviews_repository.dart';
import 'package:moreway/module/place/domain/entity/review.dart';

class PlaceReviewsRepositoryAPI implements IPlaceReviewsRepository {
  @override
  Future<List<Review>> getReviews(String id, {String? cursor}) {
    // TODO: implement getReviews
    throw UnimplementedError();
  }
}
