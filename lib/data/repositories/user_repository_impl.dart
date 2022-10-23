import 'dart:io';

import '../../domain/domain.dart';
import '../data.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource dataSource = UserDataSourceImpl();
  @override
  Future<void> addUserData(UserModel newUser) =>
      dataSource.addUserData(newUser);

  @override
  Future<UserEntity> getUserById(String uid) => dataSource.getUserById(uid);

  @override
  Stream<UserEntity> loggedUserStream(UserModel loggedUser) =>
      dataSource.loggedUserStream(loggedUser);

  @override
  Future<void> updateUserData(UserEntity updatedUser,
          {Map<String, dynamic>? additionalData}) =>
      dataSource.updateUserData(updatedUser, additionalData: additionalData);

  @override
  Future<void> uploadDB({required File db}) {
    return dataSource.uploadDB(db: db);
  }
}
