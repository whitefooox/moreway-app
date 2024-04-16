import 'package:injectable/injectable.dart';
import 'package:moreway/module/place/domain/dependency/i_place_repository.dart';
import 'package:moreway/module/place/domain/entity/place_filter_options.dart';

@Singleton()
class GetFiltersUsecase {
  final IPlaceRepository _placeRepository;

  GetFiltersUsecase(this._placeRepository);

  Future<PlaceFilterOptions> execute() {
    return _placeRepository.getFilters();
  }
}
