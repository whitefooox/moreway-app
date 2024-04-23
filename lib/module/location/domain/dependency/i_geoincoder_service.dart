import 'package:moreway/module/location/domain/entity/position_point.dart';

abstract class IGeoincoderService {
  Future<String> getCity(PositionPoint position);
}
