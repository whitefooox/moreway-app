part of 'location_v2_bloc.dart';

@immutable
sealed class LocationV2State {}

final class LocationV2Loading extends LocationV2State {}

final class LocationV2Loaded extends LocationV2State {
  final Position location;

  LocationV2Loaded({required this.location});
}

final class LocationV2Failure extends LocationV2State {}
