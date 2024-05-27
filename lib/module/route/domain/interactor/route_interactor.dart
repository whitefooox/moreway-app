import 'package:moreway/core/api/paginated_page.dart';
import 'package:moreway/module/route/domain/dependency/i_route_repository.dart';
import 'package:moreway/module/route/domain/entity/route.dart';

class RouteInteractor {
  final IRouteRepository _routeRepository;

  RouteInteractor(this._routeRepository);

  Future<PaginatedPage<Route>> getRoutes({String? cursor}){
    return _routeRepository.getRoutes();
  }
}