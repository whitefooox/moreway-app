import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/core/api/paginated_page.dart';
import 'package:moreway/module/place/domain/entity/place_detailed.dart';
import 'package:moreway/module/place/domain/usecase/place_interactor.dart';
import 'package:moreway/module/review/domain/entity/review.dart';
import 'package:moreway/module/review/domain/entity/review_raw.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlaceInteractor _placeInteractor;

  PlaceBloc(this._placeInteractor) : super(PlaceState()) {
    on<PlaceLoadEvent>(_load);
    on<CreateReviewPlaceEvent>(_createReview);
    on<LoadMoreReviewsPlaceEvent>(_loadMoreReviews);
  }

  Future<void> _loadPlaceDetailed(Emitter<PlaceState> emit) async {
    emit(state.copyWith(placeDetailedStatus: LoadingStatus.loading));
    try {
      final place = await _placeInteractor.getPlaceDetailed(state.placeId!);
      emit(state.copyWith(
          placeDetailedStatus: LoadingStatus.success, place: place));
    } catch (e) {
      emit(state.copyWith(placeDetailedStatus: LoadingStatus.failure));
    }
  }

  Future<void> _loadReviews(Emitter<PlaceState> emit) async {
    emit(state.copyWith(reviewsStatus: LoadingStatus.loading));
    try {
      final reviewsPage =
          await _placeInteractor.getReviews(placeId: state.placeId!);
      emit(state.copyWith(
          reviewsStatus: LoadingStatus.success,
          reviewsCursor: reviewsPage.cursor,
          reviews: reviewsPage.items,
          reviewsHasReachedMax: reviewsPage.cursor == null));
    } catch (e) {
      emit(state.copyWith(reviewsStatus: LoadingStatus.failure));
    }
  }

  void _load(PlaceLoadEvent event, Emitter<PlaceState> emit) async {
    emit(state.copyWith(placeId: event.id));
    await _loadPlaceDetailed(emit);
    await _loadReviews(emit);
  }

  void _createReview(
      CreateReviewPlaceEvent event, Emitter<PlaceState> emit) async {
    emit(state.copyWith(createReviewStatus: LoadingStatus.loading));
    try {
      await _placeInteractor.createReview(
          placeId: state.placeId!, review: event.review);
      emit(state.copyWith(createReviewStatus: LoadingStatus.success));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(createReviewStatus: LoadingStatus.failure));
    }
  }

  void _loadMoreReviews(
      LoadMoreReviewsPlaceEvent event, Emitter<PlaceState> emit) async {
    try {
      emit(state.copyWith(reviewsStatus: LoadingStatus.loading));
      final reviewsPage = await _placeInteractor.getReviews(
          placeId: state.placeId!, cursor: state.reviewsCursor);
      emit(state.copyWith(
          reviews: state.reviews! + reviewsPage.items,
          reviewsStatus: LoadingStatus.success,
          reviewsCursor: reviewsPage.cursor,
          reviewsHasReachedMax: reviewsPage.cursor == null));
    } catch (e) {
      emit(state.copyWith(reviewsStatus: LoadingStatus.failure));
    }
  }
}
