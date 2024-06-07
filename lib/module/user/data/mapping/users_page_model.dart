import 'package:json_annotation/json_annotation.dart';
import 'package:moreway/core/api/paginated_page.dart';

import 'package:moreway/module/user/data/mapping/user_preview_model.dart';
import 'package:moreway/module/user/data/mapping/user_relationship_model.dart';
import 'package:moreway/module/user/domain/entity/user_relationship.dart';

part 'users_page_model.g.dart';

@JsonSerializable()
class UsersPageModel {
  @JsonKey(name: "data")
  final List<UserRelationshipModel> users;

  @JsonKey(name: "meta", fromJson: _cursorFromJson)
  final String? cursor;
  UsersPageModel({
    required this.users,
    this.cursor,
  });

  static String? _cursorFromJson(Map<String, dynamic> json) {
    return json["cursor"] as String?;
  }

  factory UsersPageModel.fromJson(Map<String, dynamic> json) =>
      _$UsersPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$UsersPageModelToJson(this);

  PaginatedPage<UserRelationship> toUsersRelationship() {
    return PaginatedPage(
        items: users.map((e) => e.toUserRelationship()).toList(), cursor: cursor);
  }
}
