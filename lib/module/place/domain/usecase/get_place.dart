import 'package:injectable/injectable.dart';
import 'package:moreway/core/di/inject.dart';
import 'package:moreway/module/place/domain/dependency/i_place_repository.dart';
import 'package:moreway/module/place/domain/entity/place_detailed.dart';

@Singleton(env: [Env.dev, Env.prod])
class GetPlaceUsecase {
  final IPlaceRepository _placeRepository;

  GetPlaceUsecase(this._placeRepository);

  Future<PlaceDetailed> execute(String placeId) async {
    return _placeRepository.getPlaceById(placeId);
  }
}
