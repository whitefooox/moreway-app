part of 'created_routes_bloc.dart';

class CreatedRoutesState {
  final LoadingStatus status;
  final bool hasReachedMax;
  final String? errorMessage;
  final List<Route>? routes;
  final String? cursor;

  CreatedRoutesState({
    this.status = LoadingStatus.initial,
    this.errorMessage,
    this.routes,
    this.cursor,
    this.hasReachedMax = false,
  });

  CreatedRoutesState resetData() {
    return copyWith(
      status: LoadingStatus.initial,
      hasReachedMax: false,
      routes: () => null,
      errorMessage: null,
      cursor: null,
    );
  }

  CreatedRoutesState copyWith(
      {LoadingStatus? status,
      bool? hasReachedMax,
      String? errorMessage,
      List<Route>? Function()? routes,
      String? cursor,
      LoadingStatus? removeStatus}) {
    return CreatedRoutesState(
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
      routes: routes != null ? routes() : this.routes,
      cursor: cursor ?? this.cursor,
    );
  }
}
