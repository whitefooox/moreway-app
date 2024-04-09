import 'package:moreway/module/place/domain/entity/place_filters.dart';
import 'package:moreway/module/place/domain/entity/place_page.dart';
import 'package:moreway/module/place/domain/entity/place_sort_type.dart';

abstract class IPlaceRepository {
  Future<PlacePage> get({String? cursor, PlaceFilters? filters});
}
