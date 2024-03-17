import 'package:json_annotation/json_annotation.dart';

part 'signup_data_model.g.dart';

@JsonSerializable()
class SignUpDataModel {
  final String name;
  final String email;
  final String password;

  SignUpDataModel({
    required this.name,
    required this.email,
    required this.password,
  });

  factory SignUpDataModel.fromJson(Map<String, dynamic> json) => _$SignUpDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpDataModelToJson(this);
}
