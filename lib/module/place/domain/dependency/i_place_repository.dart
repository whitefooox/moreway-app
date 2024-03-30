import 'package:moreway/module/place/domain/entity/place.dart';

abstract class IPlaceRepository {
  Future<List<Place>> getAll();
}