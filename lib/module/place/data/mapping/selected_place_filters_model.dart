import 'package:json_annotation/json_annotation.dart';
import 'package:moreway/module/place/domain/entity/selected_place_filters.dart';

part 'selected_place_filters_model.g.dart';

String _rangeToString(List<double> range) {
  return "${range[0]}-${range[1]}";
}

String _rangeToString2(List<int> range) {
  return "${range[0]}-${range[1]}";
}

@JsonSerializable()
class SelectedPlaceFiltersModel {
  final String? search;

  @JsonKey(name: "rating", toJson: _rangeToString)
  final List<double> rangeRating;

  @JsonKey(name: "distance", toJson: _rangeToString2)
  final List<int> distance;

  final String? type;

  final String? locality;

  SelectedPlaceFiltersModel({
    this.search,
    required this.rangeRating,
    required this.distance,
    this.type,
    this.locality,
  });

  factory SelectedPlaceFiltersModel.fromDomain(SelectedPlaceFilters filters) {
    return SelectedPlaceFiltersModel(
        rangeRating: filters.rangeRating,
        distance: filters.distance,
        search: filters.search,
        type: filters.type,
        locality: filters.locality);
  }

  factory SelectedPlaceFiltersModel.fromJson(Map<String, dynamic> json) =>
      _$SelectedPlaceFiltersModelFromJson(json);

  Map<String, dynamic> toJson() => _$SelectedPlaceFiltersModelToJson(this);
}
