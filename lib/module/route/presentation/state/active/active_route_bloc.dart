import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/module/route/domain/entity/route_detailed.dart';
import 'package:moreway/module/route/domain/interactor/active_route_interactor.dart';

part 'active_route_event.dart';
part 'active_route_state.dart';

class ActiveRouteBloc extends Bloc<ActiveRouteEvent, ActiveRouteState> {

  final ActiveRouteInteractor _activeRouteInteractor;

  ActiveRouteBloc(this._activeRouteInteractor) : super(ActiveRouteState()) {
    on<LoadActiveRouteEvent>(_load);
  }

  void _load(LoadActiveRouteEvent event, Emitter<ActiveRouteState> emit) async {
    emit(state.copyWith(activeRoutestatus: LoadingStatus.loading));
    try {
      final activeRoute = await _activeRouteInteractor.getActiveRoute();
      emit(state.copyWith(activeRoute: activeRoute, activeRoutestatus: LoadingStatus.success));
    } catch (e) {
      emit(state.copyWith(activeRoutestatus: LoadingStatus.failure));
    }
  }
}
