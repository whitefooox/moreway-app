import 'package:moreway/core/api/paginated_page.dart';
import 'package:moreway/module/user/domain/entity/user_preview.dart';
import 'package:moreway/module/user/domain/entity/user_profile.dart';
import 'package:moreway/module/user/domain/dependency/i_user_repository.dart';
import 'package:moreway/module/user/domain/entity/user_relationship.dart';

class UserInteractor {

  final IUserRepository _userRepository;

  UserInteractor(this._userRepository);

  Future<UserProfile> getProfileData(){
    return _userRepository.getProfileData();
  }

  Future<PaginatedPage<UserPreview>> getFriends() async {
    return _userRepository.getFriends(userId: await _userRepository.getUserId());
  }

  Future<PaginatedPage<UserPreview>> getFriendRequests() async {
    return _userRepository.getFriendRequests(userId: await _userRepository.getUserId());
  }

  Future<PaginatedPage<UserRelationship>> searchUsers({String? name, String? cursor}){
    return _userRepository.getUsersByName(name: name, cursor: cursor);
  }
}