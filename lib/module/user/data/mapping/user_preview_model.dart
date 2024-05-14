
import 'package:json_annotation/json_annotation.dart';
import 'package:moreway/module/user/domain/entity/user_preview.dart';

part 'user_preview_model.g.dart';

@JsonSerializable()
class UserPreviewModel {
  final int id;
  final String name;
  final String avatar;

  UserPreviewModel({
    required this.id,
    required this.name,
    required this.avatar,
  });

  factory UserPreviewModel.fromJson(Map<String, dynamic> json) =>
    _$UserPreviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserPreviewModelToJson(this);

  UserPreview toUserPreview(){
    return UserPreview(id: id.toString(), name: name, avatarUrl: avatar);
  }
}
