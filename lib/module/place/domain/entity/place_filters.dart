class PlaceFilters {
  final String? search;

  const PlaceFilters({this.search});

  PlaceFilters copyWith({String? search}) => PlaceFilters(search: search);
}
