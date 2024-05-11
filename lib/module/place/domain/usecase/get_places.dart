import 'package:moreway/core/api/paginated_page.dart';
import 'package:moreway/module/place/domain/dependency/i_place_repository.dart';
import 'package:moreway/module/place/domain/entity/place.dart';
import 'package:moreway/module/place/domain/entity/place_sort_type.dart';
import 'package:moreway/module/place/domain/entity/selected_place_filters.dart';

class GetPlacesUseCase {
  final IPlaceRepository _placeRepository;

  GetPlacesUseCase(this._placeRepository);

  Future<PaginatedPage<Place>> execute(
      {String? cursor,
      PlaceSortType? sortType,
      SelectedPlaceFilters? filters}) {
    return _placeRepository.getPlaces(cursor: cursor, filters: filters);
  }
}
