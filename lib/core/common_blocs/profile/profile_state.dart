part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserEntity loggedUser;

  const ProfileLoaded(this.loggedUser);

  @override
  List<Object> get props => [loggedUser];

  @override
  String toString() {
    return "{ProfileLoaded: loggedUser:${loggedUser.toString()}}";
  }
}

class ProfileLoadFailure extends ProfileState {
  final String error;

  const ProfileLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
