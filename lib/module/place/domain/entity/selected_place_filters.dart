// ignore_for_file: public_member_api_docs, sort_constructors_first
class SelectedPlaceFilters {
  final String? search;
  final List<double>? rangeRating;
  final List<int>? distance;
  final String? type;
  final String? locality;

  const SelectedPlaceFilters({
    this.search,
    this.rangeRating,
    this.distance,
    this.type,
    this.locality,
  });

  @override
  String toString() {
    return 'SelectedPlaceFilters(search: $search, rangeRating: $rangeRating, distance: $distance, type: $type, locality: $locality)';
  }

  SelectedPlaceFilters copyWithNull({
    String? Function()? search,
    List<double>? Function()? rangeRating,
    List<int>? Function()? distance,
    String? Function()? type,
    String? Function()? locality,
  }) {
    return SelectedPlaceFilters(
        search: search != null ? search() : this.search,
        rangeRating: rangeRating != null ? rangeRating() : this.rangeRating,
        distance: distance != null ? distance() : this.distance,
        type: type != null ? type() : this.type,
        locality: locality != null ? locality() : this.locality);
  }

  bool isReseted() {
    if (search == null &&
        rangeRating == null &&
        distance == null &&
        type == null &&
        locality == null) {
      return true;
    } else {
      return false;
    }
  }
}
