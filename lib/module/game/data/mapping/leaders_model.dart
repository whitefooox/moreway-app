import 'package:json_annotation/json_annotation.dart';

import 'package:moreway/module/game/data/mapping/user_score_position_model.dart';
import 'package:moreway/module/game/domain/entity/user_score_position.dart';

part 'leaders_model.g.dart';

@JsonSerializable()
class LeadersModel {
  final List<UserScorePositionModel> leaders;
  final UserScorePositionModel userRating;

  LeadersModel({
    required this.leaders,
    required this.userRating,
  });

  factory LeadersModel.fromJson(Map<String, dynamic> json) =>
      _$LeadersModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeadersModelToJson(this);

  List<UserScorePosition> toUserScorePositionList() {
    return leaders.map((e) => e.toUserScorePosition()).toList()
      ..add(userRating.toUserScorePosition());
  }
}
