import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/module/auth/domain/entity/user_profile.dart';
import 'package:moreway/module/user/domain/entity/user_preview.dart';
import 'package:moreway/module/user/domain/interactor/user_interactor.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  final UserInteractor _userInteractor;

  UserBloc(this._userInteractor) : super(UserState()) {
    on<LoadUserEvent>(_load);
  }

  void _load(LoadUserEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    try {
      final userInfo = await _userInteractor.getProfileData();
      emit(state.copyWith(loadingStatus: LoadingStatus.success, user: userInfo));
    } catch (e) {
      emit(state.copyWith(loadingStatus: LoadingStatus.failure));
    }
  }
}
