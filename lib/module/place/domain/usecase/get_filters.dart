import 'package:moreway/module/place/domain/dependency/i_filter_repository.dart';
import 'package:moreway/module/place/domain/entity/place_filter_options.dart';

class GetFiltersUsecase {
  final IFilterRepository _filterRepository;

  GetFiltersUsecase(this._filterRepository);

  Future<PlaceFilterOptions> execute() {
    return _filterRepository.getAll();
  }
}
