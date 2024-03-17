// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInDataModel _$SignInDataModelFromJson(Map<String, dynamic> json) =>
    SignInDataModel(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SignInDataModelToJson(SignInDataModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
