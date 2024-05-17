import 'package:moreway/module/auth/domain/entity/user_profile.dart';
import 'package:moreway/module/user/domain/dependency/i_user_repository.dart';

class UserInteractor {

  final IUserRepository _userRepository;

  UserInteractor(this._userRepository);

  Future<UserProfile> getProfileData(){
    return _userRepository.getProfileData();
  }
}