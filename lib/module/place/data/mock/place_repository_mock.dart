import 'package:injectable/injectable.dart';
import 'package:moreway/core/di/inject.dart';
import 'package:moreway/module/place/domain/dependency/i_place_repository.dart';
import 'package:moreway/module/place/domain/entity/place.dart';
import 'package:moreway/module/place/domain/entity/place_detailed.dart';
import 'package:moreway/module/place/domain/entity/place_page.dart';
import 'package:moreway/module/place/domain/entity/selected_place_filters.dart';

@Singleton(as: IPlaceRepository, env: [Env.dev])
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

  @override
  Future<PlaceDetailed> getPlaceById(String id) async {
    return PlaceDetailed(
        id: id,
        distance: 100,
        name: "Парк Ангелов",
        lat: 33.46,
        lon: -111.23,
        rating: 4.5,
        images: [
          "https://heliocity.ru/wp-content/uploads/2019/11/osveshchenie-parka-angelov-002-1322x800.jpg",
          "https://visit-kuzbass.ru/assets/components/phpthumbof/cache/%D0%BF%D0%B0%D1%80%D0%BA%20%D0%B0%D0%BD%D0%B3%D0%B5%D0%BB%D0%BE%D0%B2%205%20-%20Daria%20Ushakova.0d9bbc27b0bc94321084d2e4de1e7688674.jpeg",
          "https://cdnstatic.rg.ru/uploads/images/gallery/f1ec4df4/4_91631030.jpg",
          "https://ndn.info/wp-content/uploads/2019/09/d28e53dda52526c5a9e9713696fab53c-1028x570.jpg",
          "https://heliocity.ru/wp-content/uploads/2019/11/osveshchenie-parka-angelov-005-1322x800.jpg"
        ],
        location: "Кемерово",
        type: "Парк",
        description:
            '''По замыслу архитектора дизайн парка – воплощение радости детства и единства с природой Кузбасса.
                        Для этого здесь создан искусственный ландшафт, характерный для нашего края:
                        холмы, которые служат
                        защитой от шума города, огромные каменные валуны, имитирующие горный пейзаж.
                        Посажены живые кустарники и деревья – представители сибирской тайги.''');
  }
}
