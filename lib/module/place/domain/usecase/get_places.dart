import 'package:injectable/injectable.dart';
import 'package:moreway/module/place/domain/dependency/i_place_repository.dart';
import 'package:moreway/module/place/domain/entity/place.dart';

@Singleton()
class GetPlacesUseCase {

  final IPlaceRepository _placeRepository;

  GetPlacesUseCase(this._placeRepository);
  
  Future<List<Place>> execute(){
    return _placeRepository.getAll();
  }
}