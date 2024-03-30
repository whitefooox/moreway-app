part of 'launch_bloc.dart';

class LaunchState {
  final bool isFirstLaunch;
  
  LaunchState({
    this.isFirstLaunch = true,
  });

  LaunchState copyWith({
    bool? isFirstLaunch,
  }) {
    return LaunchState(
      isFirstLaunch: isFirstLaunch ?? this.isFirstLaunch,
    );
  }
}
