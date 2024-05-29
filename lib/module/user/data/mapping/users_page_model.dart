import 'package:json_annotation/json_annotation.dart';
import 'package:moreway/core/api/paginated_page.dart';

import 'package:moreway/module/user/data/mapping/user_preview_model.dart';
import 'package:moreway/module/user/domain/entity/user_preview.dart';
import 'package:moreway/module/user/domain/entity/user_profile.dart';

part 'users_page_model.g.dart';

@JsonSerializable()
class UsersPageModel {
  @JsonKey(name: "data")
  final List<UserPreviewModel> users;

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

  PaginatedPage<UserPreview> toUserProfilePage() {
    return PaginatedPage(
        items: users.map((e) => e.toUserPreview()).toList(), cursor: cursor);
  }
}
