import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/core/api/paginated_page.dart';
import 'package:moreway/module/user/domain/entity/user_preview.dart';
import 'package:moreway/module/user/domain/entity/user_relationship.dart';
import 'package:moreway/module/user/domain/interactor/user_interactor.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  final UserInteractor _userInteractor;

  FriendsBloc(this._userInteractor) : super(FriendsState()) {
    on<SearchUsersByNameEvent>(_searchByName);
    on<ResetSearchEvent>(_resetSearch);
    on<LoadFriendsEvent>(_loadFriends);
    on<LoadFriendRequestsEvent>(_loadFriendRequests);
  }

  void _loadFriendRequests(
      LoadFriendRequestsEvent event, Emitter<FriendsState> emit) async {
    emit(state.copyWith(friendRequestsStatus: LoadingStatus.loading));
    try {
      final friends = await _userInteractor.getFriendRequests();
      emit(state.copyWith(
          friendRequests: friends,
          friendRequestsStatus: LoadingStatus.success));
    } catch (e) {
      emit(state.copyWith(friendRequestsStatus: LoadingStatus.failure));
    }
  }

  void _loadFriends(LoadFriendsEvent event, Emitter<FriendsState> emit) async {
    emit(state.copyWith(friendsStatus: LoadingStatus.loading));
    try {
      final friends = await _userInteractor.getFriends();
      emit(state.copyWith(
          friends: friends, friendsStatus: LoadingStatus.success));
    } catch (e) {
      emit(state.copyWith(friendsStatus: LoadingStatus.failure));
    }
  }

  void _resetSearch(ResetSearchEvent event, Emitter<FriendsState> emit) async {
    emit(state.copyWith(
        searchStatus: LoadingStatus.initial, searchedUsers: () => null));
  }

  void _searchByName(
      SearchUsersByNameEvent event, Emitter<FriendsState> emit) async {
    emit(state.copyWith(searchStatus: LoadingStatus.loading));
    if (event.query == null) {
      emit(state.copyWith(
          searchStatus: LoadingStatus.success,
          searchedUsers: () => List.empty()));
    } else {
      try {
        final usersPage = await _userInteractor.searchUsers(name: event.query);
        emit(state.copyWith(
            searchStatus: LoadingStatus.success,
            searchedUsers: () => usersPage.items));
      } catch (e) {
        emit(state.copyWith(searchStatus: LoadingStatus.failure));
      }
    }
  }
}
