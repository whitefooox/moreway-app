part of 'favorite_routes_bloc.dart';

class FavoriteRoutesState {
    final LoadingStatus status;
  final bool hasReachedMax;
  final String? errorMessage;
  final List<Route>? routes;
  final String? cursor;

  final LoadingStatus removeStatus;

  FavoriteRoutesState({
    this.status = LoadingStatus.initial,
    this.errorMessage,
    this.routes,
    this.cursor,
    this.hasReachedMax = false,
    this.removeStatus = LoadingStatus.initial
  });

  FavoriteRoutesState resetData() {
    return copyWith(
      status: LoadingStatus.initial,
      hasReachedMax: false,
      routes: () => null,
      errorMessage: null,
      cursor: null,
    );
  }

  FavoriteRoutesState copyWith({
    LoadingStatus? status,
    bool? hasReachedMax,
    String? errorMessage,
    List<Route>? Function()? routes,
    String? cursor,
    LoadingStatus? removeStatus
  }) {
    return FavoriteRoutesState(
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
      routes: routes != null ? routes() : this.routes,
      cursor: cursor ?? this.cursor,
      removeStatus: removeStatus ?? this.removeStatus
    );
  }
}
