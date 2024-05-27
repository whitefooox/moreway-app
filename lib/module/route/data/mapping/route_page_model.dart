import 'package:json_annotation/json_annotation.dart';
import 'package:moreway/core/api/paginated_page.dart';
import 'package:moreway/module/route/data/mapping/route_model.dart';
import 'package:moreway/module/route/domain/entity/route.dart';

part 'route_page_model.g.dart';

@JsonSerializable()
class RoutePageModel {
  @JsonKey(name: "data")
  final List<RouteModel> routes;

  @JsonKey(name: "meta", fromJson: _cursorFromJson)
  final String? cursor;

  RoutePageModel({
    required this.routes,
    this.cursor,
  });

  static String? _cursorFromJson(Map<String, dynamic> json) {
    return json["cursor"] as String?;
  }

  factory RoutePageModel.fromJson(Map<String, dynamic> json) =>
      _$RoutePageModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoutePageModelToJson(this);

  PaginatedPage<Route> toRoutePage() {
    return PaginatedPage<Route>(
      items: routes.map((routeModel) => routeModel.toRoute()).toList(), 
      cursor: cursor
    );
  }
}