import 'package:injectable/injectable.dart';
import 'package:moreway/core/di/inject.dart';
import 'package:moreway/module/place/domain/dependency/i_place_repository.dart';
import 'package:moreway/module/place/domain/entity/place.dart';
import 'package:moreway/module/place/domain/entity/place_page.dart';
import 'package:moreway/module/place/domain/entity/selected_place_filters.dart';

@Environment(Env.dev)
@Singleton(as: IPlaceRepository)
class PlaceRepositoryMock implements IPlaceRepository {
  PlaceRepositoryMock();

  @override
  Future<PlacePage> getPlaces(
      {String? cursor, SelectedPlaceFilters? filters}) async {
    return PlacePage(places: [
      Place(
          id: "1",
          distance: 100,
          name: "Парк Ангелов",
          lat: 33.46,
          lon: -111.23,
          rating: 4.5,
          image:
              "https://heliocity.ru/wp-content/uploads/2019/11/osveshchenie-parka-angelov-002-1322x800.jpg",
          location: "Кемерово")
    ]);
  }
}
