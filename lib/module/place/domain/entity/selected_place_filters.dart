// ignore_for_file: public_member_api_docs, sort_constructors_first
class SelectedPlaceFilters {
  String? search;
  List<double> rangeRating;
  List<int> distance;
  String? type;
  String? locality;

  SelectedPlaceFilters({
    this.search,
    required this.rangeRating,
    required this.distance,
    this.type,
    this.locality,
  });

  @override
  String toString() {
    return 'SelectedPlaceFilters(search: $search, rangeRating: $rangeRating, distance: $distance, type: $type, locality: $locality)';
  }

  SelectedPlaceFilters copyWith({
    String? search,
    List<double>? rangeRating,
    List<int>? distance,
    String? type,
    String? locality,
  }) {
    return SelectedPlaceFilters(
      search: search ?? this.search,
      rangeRating: rangeRating ?? this.rangeRating,
      distance: distance ?? this.distance,
      type: type ?? this.type,
      locality: locality ?? this.locality,
    );
  }
}
