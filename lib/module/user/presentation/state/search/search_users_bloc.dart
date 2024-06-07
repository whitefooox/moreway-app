import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/module/user/domain/entity/user_preview.dart';
import 'package:moreway/module/user/domain/entity/user_profile.dart';
import 'package:moreway/module/user/domain/entity/user_relationship.dart';
import 'package:moreway/module/user/domain/interactor/user_interactor.dart';

part 'search_users_event.dart';
part 'search_users_state.dart';

class SearchUsersBloc extends Bloc<SearchUsersEvent, SearchUsersState> {
  final UserInteractor _userInteractor;

  SearchUsersBloc(this._userInteractor) : super(SearchUsersState()) {
    on<SearchUsersByNameEvent>(_searchByName);
  }

  void _searchByName(
      SearchUsersByNameEvent event, Emitter<SearchUsersState> emit) async {
    emit(state.copyWith(status: LoadingStatus.loading));
    if (event.query == null) {
      emit(state.copyWith(status: LoadingStatus.success, users: List.empty()));
    } else {
      try {
        final usersPage = await _userInteractor.searchUsers(name: event.query);
        emit(state.copyWith(
            status: LoadingStatus.success, users: usersPage.items));
      } catch (e) {
        emit(state.copyWith(status: LoadingStatus.failure));
      }
    }
  }
}
