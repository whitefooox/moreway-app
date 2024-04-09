import 'package:injectable/injectable.dart';
import 'package:moreway/module/place/domain/dependency/i_place_repository.dart';
import 'package:moreway/module/place/domain/entity/place_filters.dart';
import 'package:moreway/module/place/domain/entity/place_page.dart';
import 'package:moreway/module/place/domain/entity/place_sort_type.dart';

@Singleton()
class GetPlacesUseCase {
  final IPlaceRepository _placeRepository;

  GetPlacesUseCase(this._placeRepository);

  Future<PlacePage> execute(
      {String? cursor, PlaceSortType? sortType, PlaceFilters? filters}) {
    return _placeRepository.get(cursor: cursor, filters: filters);
  }
}
