
import 'package:json_annotation/json_annotation.dart';

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
}
