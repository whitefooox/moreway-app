// ignore_for_file: public_member_api_docs, sort_constructors_first
class PlaceFilterOptions {
  final List<String> localities;
  final List<String> types;
  final List<int> rangeDistance;
  final List<double> rangeRating;

  PlaceFilterOptions({
    required this.localities,
    required this.types,
    required this.rangeDistance,
    required this.rangeRating,
  });

  PlaceFilterOptions copyWith({
    List<String>? localities,
    List<String>? types,
    List<int>? rangeDistance,
    List<double>? rangeRating,
  }) {
    return PlaceFilterOptions(
      localities: localities ?? this.localities,
      types: types ?? this.types,
      rangeDistance: rangeDistance ?? this.rangeDistance,
      rangeRating: rangeRating ?? this.rangeRating,
    );
  }
}
