import 'package:moreway/module/user/domain/entity/user_preview.dart';

enum UserRelationshipType {
  friend,
  request
}

class UserRelationship {
  final UserPreview user;
  final UserRelationshipType? relationship;

  UserRelationship({
    required this.user,
    this.relationship,
  });
}
