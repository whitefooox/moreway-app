import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/module/place/domain/entity/place.dart';
import 'package:moreway/module/route/domain/entity/indexed_place.dart';

part 'route_builder_event.dart';
part 'route_builder_state.dart';

class RouteBuilderBloc extends Bloc<RouteBuilderEvent, RouteBuilderState> {
  RouteBuilderBloc() : super(RouteBuilderState()) {
    on<RouteBuilderEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
