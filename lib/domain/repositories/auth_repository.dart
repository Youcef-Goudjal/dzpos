import '../../data/data.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../domain.dart';

/// Repository which manages user authentication
abstract class AuthRepository {
  /// Stream of [UserEntity] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [UserEnity.empty] if the user is not authenticated.
  Stream<UserEntity> get user;

  /// Returns the current cached user
  /// Defaults to [user.empty] if there is no cached user.
  UserModel get currentUser;

  /// creates a new user with the provided [email] and [password].
  ///
  /// Throw a [signUpWithEmailAndPasswordFailure] if an exceptionoccurs.
  Future<String> signUp({
    required String email,
    required String password,
  });

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<UserEntity> logInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// SignIn with Phone number
  ///
  /// Throws a [LogInWithPhoneNumberFailure] if an exception occurs.
  Future<void> logInWithPhoneNumber({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  });

  /// Signs In with Credential
  ///
  /// Throws a [LogInWithCredentialFailure] if an Exception occurs.
  Future<UserEntity?> logInWithCredential({
    required AuthCredential credential,
  });

  /// Signs out the current user which will
  /// emit [UserEntity.empty] from the [UserEntity] stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs
  Future<void> logOut();

  bool isLoggedIn();

  /// link credential to a user
  Future<void> linkCredentials(AuthCredential credential);

  /// forgot password
  Future<void> forgotPassword(String email);

  Future<void> confirmePasswordReset(String code, String newPassword);
}
