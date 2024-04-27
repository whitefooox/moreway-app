import 'package:moreway/module/place/domain/entity/place_filter_options.dart';

abstract class IFilterRepository {
  Future<PlaceFilterOptions> getAll();
}
