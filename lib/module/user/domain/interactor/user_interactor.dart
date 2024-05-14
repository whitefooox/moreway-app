import 'package:moreway/module/user/domain/dependency/i_user_repository.dart';
import 'package:moreway/module/user/domain/entity/user_preview.dart';

class UserInteractor {

  final IUserRepository _userRepository;

  UserInteractor(this._userRepository);

  Future<UserPreview> getCurrentUserInfo(){
    return _userRepository.getUserByToken();
  }
}