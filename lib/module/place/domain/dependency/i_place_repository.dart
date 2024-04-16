import 'package:moreway/module/place/domain/entity/place_filter_options.dart';
import 'package:moreway/module/place/domain/entity/place_page.dart';
import 'package:moreway/module/place/domain/entity/selected_place_filters.dart';

abstract class IPlaceRepository {
  Future<PlacePage> getPlaces({String? cursor, SelectedPlaceFilters? filters});
  Future<PlaceFilterOptions> getFilters();
}
