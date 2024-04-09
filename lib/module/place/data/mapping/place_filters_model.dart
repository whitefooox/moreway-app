import 'package:json_annotation/json_annotation.dart';
import 'package:moreway/module/place/domain/entity/place_filters.dart';

part 'place_filters_model.g.dart';

@JsonSerializable()
class PlaceFiltersModel {
  final String? search;

  PlaceFiltersModel({this.search});

  factory PlaceFiltersModel.fromDomain(PlaceFilters placeFilters) {
    return PlaceFiltersModel(search: placeFilters.search);
  }

  factory PlaceFiltersModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceFiltersModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceFiltersModelToJson(this);
}
