import 'package:dzpos/data/data.dart';
import 'package:dzpos/domain/entities/user_entity.dart';
import "package:dzpos/domain/repositories/auth_repository.dart";
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource = AuthDataSourceImpl();
  @override
  UserEntity get currentUser => authDataSource.currentUser;

  @override
  bool isLoggedIn() => authDataSource.isLoggedIn();

  @override
  Future<UserEntity?> logInWithCredential(
          {required AuthCredential credential}) =>
      authDataSource.logInWithCredential(credential: credential);

  @override
  Future<UserEntity> logInWithEmailAndPassword(
          {required String email, required String password}) =>
      authDataSource.logInWithEmailAndPassword(
          email: email, password: password);

  @override
  Future<void> logInWithPhoneNumber(
          {required String phoneNumber,
          required Function(PhoneAuthCredential p1) verificationCompleted,
          required Function(FirebaseAuthException p1) verificationFailed,
          required Function(String p1, int? p2) codeSent,
          required Function(String p1) codeAutoRetrievalTimeout}) =>
      authDataSource.logInWithPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);

  @override
  Future<void> logOut() => authDataSource.logOut();

  @override
  Future<void> signUp({required String email, required String password}) =>
      authDataSource.signUp(email: email, password: password);

  @override
  Stream<UserEntity> get user => authDataSource.user;

  @override
  Future<void> linkCredentials(AuthCredential credential) =>
      authDataSource.linkCredentials(credential);
}
