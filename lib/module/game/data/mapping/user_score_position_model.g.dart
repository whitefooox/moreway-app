// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_score_position_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserScorePositionModel _$UserScorePositionModelFromJson(
        Map<String, dynamic> json) =>
    UserScorePositionModel(
      user: UserPreviewModel.fromJson(json['user'] as Map<String, dynamic>),
      score: json['score'] as int,
      position: json['position'] as int,
    );

Map<String, dynamic> _$UserScorePositionModelToJson(
        UserScorePositionModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'score': instance.score,
      'position': instance.position,
    };
