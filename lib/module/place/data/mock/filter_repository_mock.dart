import 'package:injectable/injectable.dart';
import 'package:moreway/core/di/inject.dart';
import 'package:moreway/module/place/domain/dependency/i_filter_repository.dart';
import 'package:moreway/module/place/domain/entity/place_filter_options.dart';

@Environment(Env.dev)
@Singleton(as: IFilterRepository)
class FilterRepositoryMock implements IFilterRepository {
  @override
  Future<PlaceFilterOptions> getAll() async {
    return PlaceFilterOptions(
        localities: [],
        types: [],
        rangeDistance: [0, 100],
        rangeRating: [0, 5]);
  }
}
