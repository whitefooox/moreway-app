import 'package:moreway/module/location/domain/entity/position.dart';

abstract class ILocationService {
  Future<Position> getCurrentPosition();
  Stream<Position> getLocationStream();
}
