import 'package:cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/errors/errors.dart';
import '../data.dart';

abstract class AuthDataSource {
  /// Stream of [UserModel] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [UserEnity.empty] if the user is not authenticated.
  Stream<UserModel> get user;

  /// Returns the current cached user
  /// Defaults to [user.empty] if there is no cached user.
  UserModel get currentUser;

  /// creates a new user with the provided [email] and [password].
  ///
  /// Throw a [signUpWithEmailAndPasswordFailure] if an exceptionoccurs.
  Future<void> signUp({
    required String email,
    required String password,
  });

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<UserModel> logInWithEmailAndPassword({
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
  Future<UserModel?> logInWithCredential({
    required AuthCredential credential,
  });

  /// Signs out the current user which will
  /// emit [UserModel.empty] from the [UserModel] stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs
  Future<void> logOut();

  bool isLoggedIn();

  /// link credential to a user
  Future<void> linkCredentials(AuthCredential credential);
}

class AuthDataSourceImpl implements AuthDataSource {
  final _auth = FirebaseAuth.instance;
  final CacheClient _cache = CacheClient();
  static const userCacheKey = "__user_cache_key__";
  @override
  UserModel get currentUser =>
      _auth.currentUser?.toUserModel ?? UserModel.empty;

  @override
  bool isLoggedIn() => _auth.currentUser != null;

  @override
  Future<void> linkCredentials(AuthCredential credential) async {
    try {
      _auth.currentUser?.linkWithCredential(credential);
    } on FirebaseAuthException catch (err) {
      throw LinkWithCredentialFailure.fromCode(err.code);
    } catch (e) {
      throw LinkWithCredentialFailure();
    }
  }

  @override
  Future<UserModel> logInWithCredential(
      {required AuthCredential credential}) async {
    try {
      final userCredential = await _auth.signInWithCredential(credential);
      if (userCredential.user == null) {
        return UserModel.empty;
      }
      return userCredential.user!.toUserModel;
    } on FirebaseAuthException catch (e) {
      throw LogInWithCredentialFailure.fromCode(e.code);
    } catch (e) {
      throw const LogInWithCredentialFailure();
    }
  }

  @override
  Future<UserModel> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user == null) {
        return UserModel.empty;
      } else {
        return userCredential.user!.toUserModel;
      }
    } on FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<void> logInWithPhoneNumber(
      {required String phoneNumber,
      required Function(PhoneAuthCredential p1) verificationCompleted,
      required Function(FirebaseAuthException p1) verificationFailed,
      required Function(String p1, int? p2) codeSent,
      required Function(String p1) codeAutoRetrievalTimeout}) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: "+213$phoneNumber",
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  @override
  Future<void> logOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }

  @override
  Future<void> signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  @override
  Stream<UserModel> get user {
    return _auth.authStateChanges().map((firebaseUser) {
      final UserModel user =
          firebaseUser == null ? UserModel.empty : firebaseUser.toUserModel;

      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }
}
