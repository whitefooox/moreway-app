import 'package:moreway/module/location/data/mapper/position_model.dart';
import 'package:moreway/module/place/data/mapping/selected_place_filters_model.dart';
import 'package:moreway/module/place/domain/entity/selected_place_filters.dart';

class PlaceQueryParametersBuilder {
  final Map<String, dynamic> _parameters = {};

  PlaceQueryParametersBuilder setPosition(PositionModel position) {
    _parameters.addAll(position.toJson());
    return this;
  }

  PlaceQueryParametersBuilder setPlaceId(String id) {
    _parameters['placeId'] = id;
    return this;
  }

  PlaceQueryParametersBuilder setCursor(String? cursor) {
    if (cursor != null) {
      _parameters['cursor'] = cursor;
    }
    return this;
  }

  PlaceQueryParametersBuilder setLimit(int limit) {
    _parameters['limit'] = limit;
    return this;
  }

  PlaceQueryParametersBuilder setFilters(SelectedPlaceFilters? filters) {
    if (filters != null) {
      _parameters
          .addAll(SelectedPlaceFiltersModel.fromDomain(filters).toJson());
    }
    return this;
  }

  void _removeNullParams() {
    _parameters.removeWhere((key, value) => value == null);
  }

  Map<String, dynamic> build() {
    _removeNullParams();
    return _parameters;
  }
}
