import 'package:json_annotation/json_annotation.dart';
import 'package:moreway/core/api/paginated_page.dart';
import 'package:moreway/module/user/data/mapping/user_preview_model.dart';
import 'package:moreway/module/user/domain/entity/user_preview.dart';
import 'package:moreway/module/user/domain/entity/user_relationship.dart';

part 'friends_page_model.g.dart';

@JsonSerializable()
class FriendsPageModel {
  final List<UserPreviewModel> data;

  @JsonKey(name: "meta", fromJson: _cursorFromJson)
  final String? cursor;

  FriendsPageModel({
    required this.data,
    this.cursor,
  });

  static String? _cursorFromJson(Map<String, dynamic> json) {
    return json["cursor"] as String?;
  }

  factory FriendsPageModel.fromJson(Map<String, dynamic> json) =>
      _$FriendsPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$FriendsPageModelToJson(this);

  PaginatedPage<UserPreview> toUsersPreview() {
    return PaginatedPage(
        items: data.map((e) => e.toUserPreview()).toList(), cursor: cursor);
  }
}
