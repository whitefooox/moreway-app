import 'package:moreway/module/user/domain/dependency/i_user_repository.dart';
import 'package:moreway/module/user/domain/entity/user_info.dart';

class UserInteractor {

  final IUserRepository _userRepository;

  UserInteractor(this._userRepository);

  Future<UserInfo> getCurrentUserInfo(){
    return _userRepository.getUserByToken();
  }
}