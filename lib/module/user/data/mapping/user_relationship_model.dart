import 'package:json_annotation/json_annotation.dart';

import 'package:moreway/module/user/data/mapping/user_preview_model.dart';
import 'package:moreway/module/user/domain/entity/user_relationship.dart';

part 'user_relationship_model.g.dart';

enum UserRelationshipTypeModel {
  @JsonValue("friend")
  friend,
  @JsonValue("request")
  request,
}

UserRelationshipType? toUserRelationshipType(UserRelationshipTypeModel? type) {
  switch (type) {
    case UserRelationshipTypeModel.friend:
      return UserRelationshipType.friend;
    case UserRelationshipTypeModel.request:
      return UserRelationshipType.request;
    default:
      null;
  }
  return null;
}

@JsonSerializable()
class UserRelationshipModel {
  final UserPreviewModel user;
  final UserRelationshipTypeModel? relationship;

  UserRelationshipModel({
    required this.user,
    this.relationship,
  });

  factory UserRelationshipModel.fromJson(Map<String, dynamic> json) =>
      _$UserRelationshipModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserRelationshipModelToJson(this);

  UserRelationship toUserRelationship() {
    return UserRelationship(
        user: user.toUserPreview(),
        relationship: toUserRelationshipType(relationship));
  }
}
