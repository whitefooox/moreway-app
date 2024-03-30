part of 'launch_bloc.dart';

@immutable
sealed class LaunchEvent {}

class CheckFirstLaunchEvent extends LaunchEvent {} 

class SetFirstStatusLaunchEvent extends LaunchEvent {
  final bool status;

  SetFirstStatusLaunchEvent(this.status);
} 
