import 'package:moreway/core/api/paginated_page.dart';
import 'package:moreway/module/review/domain/entity/review.dart';
import 'package:moreway/module/place/domain/entity/place.dart';
import 'package:moreway/module/place/domain/entity/place_detailed.dart';
import 'package:moreway/module/place/domain/entity/selected_place_filters.dart';
import 'package:moreway/module/review/domain/entity/review_raw.dart';

abstract class IPlaceRepository {
  Future<PaginatedPage<Place>> getPlaces({String? cursor, SelectedPlaceFilters? filters});
  Future<PlaceDetailed> getPlaceById(String id);
  Future<PaginatedPage<Review>> getReviews({String? cursor, required String placeId});
  Future<Review> createReview(String placeId, ReviewRaw review, String userId);
}
