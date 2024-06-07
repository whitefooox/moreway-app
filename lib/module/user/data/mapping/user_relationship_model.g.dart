// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_relationship_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRelationshipModel _$UserRelationshipModelFromJson(
        Map<String, dynamic> json) =>
    UserRelationshipModel(
      user: UserPreviewModel.fromJson(json['user'] as Map<String, dynamic>),
      relationship: $enumDecodeNullable(
          _$UserRelationshipTypeModelEnumMap, json['relationship']),
    );

Map<String, dynamic> _$UserRelationshipModelToJson(
        UserRelationshipModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'relationship': _$UserRelationshipTypeModelEnumMap[instance.relationship],
    };

const _$UserRelationshipTypeModelEnumMap = {
  UserRelationshipTypeModel.friend: 'friend',
  UserRelationshipTypeModel.request: 'request',
};
