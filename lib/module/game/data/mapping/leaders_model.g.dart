// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaders_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadersModel _$LeadersModelFromJson(Map<String, dynamic> json) => LeadersModel(
      leaders: (json['leaders'] as List<dynamic>)
          .map(
              (e) => UserScorePositionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      userRating: UserScorePositionModel.fromJson(
          json['userRating'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LeadersModelToJson(LeadersModel instance) =>
    <String, dynamic>{
      'leaders': instance.leaders,
      'userRating': instance.userRating,
    };
