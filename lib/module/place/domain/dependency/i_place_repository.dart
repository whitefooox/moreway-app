import 'package:moreway/module/place/domain/entity/place.dart';
import 'package:moreway/module/place/domain/entity/place_sort_type.dart';

abstract class IPlaceRepository {
  List<Place> getAll(PlaceSortType? sortType);
}