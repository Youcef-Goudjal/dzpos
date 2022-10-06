import 'dart:async';

import 'package:dzpos/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  StreamSubscription? _profileStreamSub;

  UserEntity user = UserEntity.empty;
  ProfileBloc(this._authRepository, this._userRepository)
      : super(ProfileLoading()) {
    on<LoadProfile>(_onLoadProfile);
    on<ProfileUpdated>(_onProfileUpdated);
  }

  FutureOr<void> _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) {
    _profileStreamSub?.cancel();
    _profileStreamSub = _userRepository
        .loggedUserStream(_authRepository.currentUser)
        .listen((updatedUser) {
      add(ProfileUpdated(updatedUser));
    });
  }

  FutureOr<void> _onProfileUpdated(
      ProfileUpdated event, Emitter<ProfileState> emit) {
    try {
      user = event.updatedUser;
      emit(ProfileLoaded(event.updatedUser));
    } catch (e) {
      ProfileLoadFailure(e.toString());
    }
  }

  @override
  Future<void> close() {
    _profileStreamSub?.cancel();
    user = UserEntity.empty;
    return super.close();
  }
}
