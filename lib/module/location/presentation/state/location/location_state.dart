part of 'location_bloc.dart';

enum LocationStatus { noPermission, success, initial }

class LocationState {
  final Position? currentPosition;
  final String? city;
  final LocationStatus locationStatus;

  LocationState({
    this.currentPosition,
    this.city,
    this.locationStatus = LocationStatus.initial,
  });

  LocationState copyWith({
    Position? currentPosition,
    String? city,
    LocationStatus? locationStatus,
  }) {
    return LocationState(
      currentPosition: currentPosition ?? this.currentPosition,
      city: city ?? this.city,
      locationStatus: locationStatus ?? this.locationStatus,
    );
  }
}
