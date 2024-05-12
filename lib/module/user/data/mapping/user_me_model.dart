import 'package:json_annotation/json_annotation.dart';
import 'package:moreway/module/auth/domain/entity/user_profile.dart';
import 'package:moreway/module/user/domain/entity/user_info.dart';

part 'user_me_model.g.dart';

@JsonSerializable()
class UserMeModel {
  final int id;
  final String name;
  final String avatar;
  final String email;
  
  UserMeModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.email,
  });

  factory UserMeModel.fromJson(Map<String, dynamic> json) =>
      _$UserMeModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserMeModelToJson(this);

  UserProfile toUserProfile(){
    return UserProfile(
      id: id.toString(), 
      name: name, 
      email: email, 
      avatarUrl: avatar
    );
  }
}
