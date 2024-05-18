import 'package:moreway/module/route/domain/entity/indexed_place.dart';

abstract class IRouteBuilderRepository {
  Future<List<IndexedPlace>> getConstructor();
  Future<void> addPlace();
}