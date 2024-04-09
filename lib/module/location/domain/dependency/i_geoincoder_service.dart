import 'package:moreway/module/location/domain/entity/position.dart';

abstract class IGeoincoderService {
  Future<String> getCity(Position position);
}