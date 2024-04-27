import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/module/place/domain/entity/place_detailed.dart';
import 'package:moreway/module/place/domain/usecase/get_place.dart';

part 'place_event.dart';
part 'place_state.dart';

@Injectable()
class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final GetPlaceUsecase _getPlaceUsecase;

  PlaceBloc(this._getPlaceUsecase) : super(PlaceState()) {
    on<PlaceLoadEvent>(_load);
  }

  void _load(PlaceLoadEvent event, Emitter<PlaceState> emit) async {
    log("[place id]: [${event.id}]");
    emit(state.copyWith(
        loadingStatus: LoadingStatus.loading, placeId: event.id));
    try {
      final place = await _getPlaceUsecase.execute(event.id);
      emit(state.copyWith(loadingStatus: LoadingStatus.success, place: place));
    } catch (e) {
      emit(state.copyWith(loadingStatus: LoadingStatus.failure));
    }
  }
}
