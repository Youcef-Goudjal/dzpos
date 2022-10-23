import 'dart:async';
import 'dart:io';

import 'package:dzpos/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

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
    on<UploadDBRequested>(_onUploadDBRequested);
  }

  FutureOr<void> _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) {
    _profileStreamSub?.cancel();
    // add(ProfileUpdated(_authRepository.currentUser));
    _profileStreamSub = _userRepository
        .loggedUserStream(_authRepository.currentUser)
        .listen((updatedUser) {
      print("profile updated ");
      add(ProfileUpdated(updatedUser));
    });
  }

  FutureOr<void> _onProfileUpdated(
      ProfileUpdated event, Emitter<ProfileState> emit) {
    try {
      print("");
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

  FutureOr<void> _onUploadDBRequested(
      UploadDBRequested event, Emitter<ProfileState> emit) async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final dbPath = p.join(dbFolder.path, 'db.sqlite');
    print(dbPath);
    if (dbPath != "") {
      final file = File(dbPath);
      _userRepository.uploadDB(db: file);
    }
  }
}
