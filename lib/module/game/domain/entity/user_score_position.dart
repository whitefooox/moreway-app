import 'package:moreway/module/user/domain/entity/user_preview.dart';

class UserScorePosition {
  final int score;
  final UserPreview user;
  final int position;
  
  UserScorePosition({
    required this.score,
    required this.user,
    required this.position,
  });
}
