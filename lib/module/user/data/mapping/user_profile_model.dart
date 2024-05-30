import 'package:json_annotation/json_annotation.dart';

import 'package:moreway/module/user/data/mapping/user_me_model.dart';
import 'package:moreway/module/user/domain/entity/user_profile.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel {
  final UserMeModel user;
  final int score;

  UserProfileModel({
    required this.user,
    required this.score,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);

  UserProfile toUserProfile() {
    return UserProfile(
        id: user.id.toString(), name: user.name, email: user.email, avatarUrl: user.avatar, score: score);
  }
}
