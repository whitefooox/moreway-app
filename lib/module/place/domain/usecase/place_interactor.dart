import 'package:moreway/core/api/paginated_page.dart';
import 'package:moreway/module/place/domain/dependency/i_filter_repository.dart';
import 'package:moreway/module/place/domain/dependency/i_place_repository.dart';
import 'package:moreway/module/place/domain/entity/place.dart';
import 'package:moreway/module/place/domain/entity/place_detailed.dart';
import 'package:moreway/module/place/domain/entity/place_filter_options.dart';
import 'package:moreway/module/place/domain/entity/place_sort_type.dart';
import 'package:moreway/module/place/domain/entity/selected_place_filters.dart';
import 'package:moreway/module/review/domain/entity/review.dart';

class PlaceInteractor {
  final IPlaceRepository _placeRepository;
  final IFilterRepository _filterRepository;

  PlaceInteractor(this._placeRepository, this._filterRepository);

  Future<PaginatedPage<Place>> getPlaces(
      {String? cursor,
      PlaceSortType? sortType,
      SelectedPlaceFilters? filters}) {
    return _placeRepository.getPlaces(cursor: cursor, filters: filters);
  }

  Future<PlaceDetailed> getPlaceDetailed(String id) {
    return _placeRepository.getPlaceById(id);
  }

  Future<PlaceFilterOptions> getFilters() {
    return _filterRepository.getAll();
  }

  Future<PaginatedPage<Review>> getReviews(
      {String? cursor, required String placeId}) {
    return _placeRepository.getReviews(placeId: placeId, cursor: cursor);
  }
}
