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
  final String? next_cursor;

  RoutePageModel({
    required this.routes,
    this.next_cursor,
  });

  static String? _cursorFromJson(Map<String, dynamic> json) {
    return json["next_cursor"] as String?;
  }

  factory RoutePageModel.fromJson(Map<String, dynamic> json) =>
      _$RoutePageModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoutePageModelToJson(this);

  PaginatedPage<Route> toRoutePage() {
    return PaginatedPage<Route>(
      items: routes.map((routeModel) => routeModel.toRoute()).toList(), 
      cursor: next_cursor
    );
  }
}