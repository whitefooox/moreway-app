part of 'routes_bloc.dart';

enum RoutesStatus { initial, success, failure }

class RoutesState {
  final RoutesStatus status;
  final bool hasReachedMax;
  final String? errorMessage;
  final List<Route>? routes;
  final String? cursor;

  RoutesState({
    this.status = RoutesStatus.initial,
    this.errorMessage,
    this.routes,
    this.cursor,
    this.hasReachedMax = false,
  });

  RoutesState resetData() {
    return copyWith(
      status: RoutesStatus.initial,
      hasReachedMax: false,
      routes: () => null,
      errorMessage: null,
      cursor: null,
    );
  }

  RoutesState copyWith({
    RoutesStatus? status,
    bool? hasReachedMax,
    String? errorMessage,
    List<Route>? Function()? routes,
    String? cursor,
  }) {
    return RoutesState(
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
      routes: routes != null ? routes() : this.routes,
      cursor: cursor ?? this.cursor,
    );
  }
}

