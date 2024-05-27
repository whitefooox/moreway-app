import 'package:moreway/core/api/paginated_page.dart';
import 'package:moreway/module/route/domain/entity/route.dart';

abstract class IRouteRepository {
  Future<PaginatedPage<Route>> getRoutes({String? cursor});
  //Future<RouteDetailed> getRouteById(String id);
  
}