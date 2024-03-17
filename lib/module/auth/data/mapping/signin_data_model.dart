import 'package:json_annotation/json_annotation.dart';

part 'signin_data_model.g.dart';

@JsonSerializable()
class SignInDataModel {
  final String email;
  final String password;

  SignInDataModel({
    required this.email,
    required this.password,
  });

  factory SignInDataModel.fromJson(Map<String, dynamic> json) => _$SignInDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignInDataModelToJson(this);
}
