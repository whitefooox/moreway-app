import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/core/api/paginated_page.dart';
import 'package:moreway/module/place/domain/entity/place_detailed.dart';
import 'package:moreway/module/place/domain/usecase/place_interactor.dart';
import 'package:moreway/module/review/domain/entity/review.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlaceInteractor _placeInteractor;

  PlaceBloc(this._placeInteractor) : super(PlaceState()) {
    on<PlaceLoadEvent>(_load);
  }

  void _load(PlaceLoadEvent event, Emitter<PlaceState> emit) async {
    log("[place id]: [${event.id}]");
    emit(state.copyWith(
        loadingStatus: LoadingStatus.loading, placeId: event.id));
    try {
      final results = await Future.wait([
        _placeInteractor.getPlaceDetailed(event.id),
        _placeInteractor.getReviews(placeId: event.id)
      ]);
      final place = results[0] as PlaceDetailed;
      final reviewPage = results[1] as PaginatedPage<Review>;
      emit(state.copyWith(
          loadingStatus: LoadingStatus.success,
          place: place,
          reviews: reviewPage.items,
          hasReachedMax: reviewPage.cursor == null,
          cursor: reviewPage.cursor));
    } catch (e) {
      emit(state.copyWith(loadingStatus: LoadingStatus.failure));
    }
  }

  void _createReview(CreateReviewPlaceEvent event, Emitter<PlaceState> emit) async {
    emit(state.copyWith(createReviewStatus: LoadingStatus.loading));
    try {
      
    } catch (e) {
      
    }
  }
}
