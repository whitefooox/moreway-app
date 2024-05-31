import 'package:json_annotation/json_annotation.dart';
import 'package:moreway/module/game/domain/entity/user_score_position.dart';

import 'package:moreway/module/user/data/mapping/user_preview_model.dart';

part 'user_score_position_model.g.dart';

@JsonSerializable()
class UserScorePositionModel {
  final UserPreviewModel user;
  final int score;
  final int position;

  UserScorePositionModel({
    required this.user,
    required this.score,
    required this.position,
  });

  factory UserScorePositionModel.fromJson(Map<String, dynamic> json) =>
      _$UserScorePositionModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserScorePositionModelToJson(this);

  UserScorePosition toUserScorePosition() {
    return UserScorePosition(
        score: score, user: user.toUserPreview(), position: position);
  }
}
