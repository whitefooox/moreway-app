import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moreway/module/location/domain/usecase/send_request_location_permission.dart';
import 'package:moreway/module/welcome/domain/usecase/check_first_launch.dart';
import 'package:moreway/module/welcome/domain/usecase/set_status_first_launch.dart';

part 'launch_event.dart';
part 'launch_state.dart';

class LaunchBloc extends Bloc<LaunchEvent, LaunchState> {
  final CheckFirstLaunchUseCase _checkFirstLaunchUseCase;
  final SetStatusFirstLaunchUseCase _setStatusFirstLaunchUseCase;
  final SendRequestLocationPermissionUseCase
      _sendRequestLocationPermissionUseCase;

  LaunchBloc(this._checkFirstLaunchUseCase, this._setStatusFirstLaunchUseCase,
      this._sendRequestLocationPermissionUseCase)
      : super(LaunchState()) {
    on<CheckFirstLaunchEvent>(_checkFirstLaunch);
    on<SetFirstStatusLaunchEvent>(_markFirstLaunch);
  }

  void _checkFirstLaunch(
      CheckFirstLaunchEvent event, Emitter<LaunchState> emit) async {
    final isFirstLaunch = _checkFirstLaunchUseCase.execute();
    emit(state.copyWith(isFirstLaunch: isFirstLaunch));
  }

  void _markFirstLaunch(
      SetFirstStatusLaunchEvent event, Emitter<LaunchState> emit) async {
    await _setStatusFirstLaunchUseCase.execute(event.status);
    await _sendRequestLocationPermissionUseCase.execute();
    emit(state.copyWith(isFirstLaunch: event.status));
  }
}
