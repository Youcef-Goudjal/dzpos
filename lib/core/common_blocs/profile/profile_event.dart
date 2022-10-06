part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

/// Load profile of logged firebase user in firestore
class LoadProfile extends ProfileEvent {}

/// Profile was updated
class ProfileUpdated extends ProfileEvent {
  final UserEntity updatedUser;

  const ProfileUpdated(this.updatedUser);

  @override
  List<Object> get props => [updatedUser];
}
