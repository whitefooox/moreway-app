import 'package:json_annotation/json_annotation.dart';
import 'package:moreway/module/place/data/mapping/place/place_model.dart';
import 'package:moreway/module/place/domain/entity/place_page.dart';

part 'place_page_model.g.dart';

@JsonSerializable()
class PlacePageModel {
  @JsonKey(name: "data")
  final List<PlaceModel> places;

  @JsonKey(name: "meta", fromJson: _cursorFromJson)
  final String? cursor;

  PlacePageModel({
    required this.places,
    this.cursor,
  });

  static String? _cursorFromJson(Map<String, dynamic> json) {
    return json["cursor"] as String?;
  }

  factory PlacePageModel.fromJson(Map<String, dynamic> json) =>
      _$PlacePageModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlacePageModelToJson(this);

  PlacePage toPlacePage() {
    return PlacePage(
        places: places.map((placeModel) => placeModel.toPlace()).toList(),
        cursor: cursor);
  }
}
