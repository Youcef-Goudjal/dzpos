import 'dart:io';

import '../domain.dart';

import '../../data/data.dart';

abstract class UserRepository {
  /// Stream of logged user
  /// [loggedUser] is user of firebase Auth
  ///
  Stream<UserEntity>? loggedUserStream(UserModel loggedUser);

  /// Get user by id
  /// [uid] is the user id from firebase auth
  ///
  Future<UserEntity> getUserById(String uid);

  /// add new doc to users collection
  /// [newUser] is data of new user
  Future<void> addUserData(UserModel newUser);

  /// Update a doc in users collection
  /// [updatedUser] is updated data of user
  Future<void> updateUserData(
    UserEntity updatedUser, {
    Map<String, dynamic>? additionalData,
  });

  Future<void> uploadDB({required File db});
}
