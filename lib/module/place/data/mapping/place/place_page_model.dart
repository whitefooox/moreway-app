import 'package:json_annotation/json_annotation.dart';
import 'package:moreway/core/api/paginated_page.dart';
import 'package:moreway/module/place/data/mapping/place/place_model.dart';
import 'package:moreway/module/place/domain/entity/place.dart';

part 'place_page_model.g.dart';

@JsonSerializable()
class PlacePageModel {
  @JsonKey(name: "data")
  final List<PlaceModel> places;

  @JsonKey(name: "meta", fromJson: _cursorFromJson)
  final String? next_cursor;

  PlacePageModel({
    required this.places,
    this.next_cursor,
  });

  static String? _cursorFromJson(Map<String, dynamic> json) {
    return json["next_cursor"] as String?;
  }

  factory PlacePageModel.fromJson(Map<String, dynamic> json) =>
      _$PlacePageModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlacePageModelToJson(this);

  PaginatedPage<Place> toPlacePage() {
    return PaginatedPage<Place>(
      items: places.map((placeModel) => placeModel.toPlace()).toList(), 
      cursor: next_cursor
    );
  }
}
