import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dzpos/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../data.dart';

abstract class UserDataSource {
  /// Stream of logged user
  /// [loggedUser] is user of firebase Auth
  ///
  Stream<UserModel>? loggedUserStream(UserModel loggedUser);

  /// Get user by id
  /// [uid] is the user id from firebase auth
  ///
  Future<UserModel> getUserById(String uid);

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

class UserDataSourceImpl implements UserDataSource {
  final _userCollection = FirebaseFirestore.instance.collection("users");
  final storage = FirebaseStorage.instance.ref("db");
  @override
  Future<void> addUserData(UserModel newUser) async {
    return await _userCollection.doc(newUser.uid).set(newUser.toJson());
  }

  @override
  Future<UserModel> getUserById(String uid) async {
    return await _userCollection
        .doc(uid)
        .get()
        .then((doc) => UserModel.fromMap(doc.data()));
  }

  @override
  Stream<UserModel>? loggedUserStream(UserModel loggedUser) {
    if (loggedUser.isEmpty) {
      return null;
    }
    return _userCollection
        .doc(loggedUser.uid)
        .snapshots()
        .map((event) => UserModel.fromMap(event.data()));
  }

  @override
  Future<void> updateUserData(UserEntity updatedUser,
      {Map<String, dynamic>? additionalData}) async {
    await _userCollection.doc(updatedUser.uid).get().then(
      (doc) async {
        Map<String, dynamic> data = UserModel.fromEntity(updatedUser).toJson();
        if (additionalData != null) data.addAll(additionalData);
        if (doc.exists) {
          // update
          await doc.reference.update(data);
        } else {
          await doc.reference.set(data);
        }
      },
    );
  }

  @override
  Future<void> uploadDB({required File db}) async {
    storage.child(FirebaseAuth.instance.currentUser!.uid).putFile(db);
  }
}
