/// Thrown if during the sign up process if a failure occurs
class SignUpWithEmailAndPasswordFailure implements Exception {
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred',
  ]);
  final String message;

  /// create an authentication message
  /// from a firebase auth exception code.
  ///
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

  @override
  String toString() {
    return message;
  }
}

///  log_in_with_email_and_password_failure
/// Thrown during the login process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithEmailAndPassword.html
///
class LogInWithEmailAndPasswordFailure implements Exception {
  @override
  String toString() {
    return message;
  }

  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  final String message;
}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {
  @override
  String toString() {
    return "LogOut error";
  }
}

/// Throw during the sign in with phone number if a failure occurs.
class LogInWithPhoneNumberFailure implements Exception {
  @override
  String toString() {
    return message;
  }

  const LogInWithPhoneNumberFailure({
    this.message = "An unknown exception occurred.",
  });

  factory LogInWithPhoneNumberFailure.fromCode(String code) {
    switch (code) {
      case "invalid-phone-number":
        return const LogInWithPhoneNumberFailure(
          message: "The provided phone number is not valid.",
        );
      default:
        return const LogInWithPhoneNumberFailure();
    }
  }

  final String message;
}

/// Throw during the sign in with Credential if a failure occurs.
class LogInWithCredentialFailure implements Exception {
  @override
  String toString() {
    return message;
  }

  const LogInWithCredentialFailure({
    this.message = "An unknown exception occurred.",
  });
  final String message;
  factory LogInWithCredentialFailure.fromCode(String code) {
    switch (code) {
      case "invalid-phone-number":
        return const LogInWithCredentialFailure(
          message: "The provided phone number is not valid.",
        );
      case "account-exists-with-different-credential":
        return const LogInWithCredentialFailure(
          message:
              "Thrown if there already exists an account with the email address asserted by the credential. Resolve this by calling [fetchSignInMethodsForEmail] and then asking the user to sign in using one of the returned providers. Once the user is signed in, the original credential can be linked to the user with [linkWithCredential]",
        );
      case "invalid-credential":
        return const LogInWithCredentialFailure(
          message: "Thrown if the credential is malformed or has expired.",
        );
      case "operation-not-allowed":
        return const LogInWithCredentialFailure(
          message:
              "Thrown if the type of account corresponding to the credential is not enabled. Enable the account type in the Firebase Console, under the Auth tab.",
        );
      case "user-disabled":
        return const LogInWithCredentialFailure(
          message:
              "Thrown if the user corresponding to the given credential has been disabled.",
        );
      case "user-not-found":
        return const LogInWithCredentialFailure(
          message:
              "Thrown if signing in with a credential from [EmailAuthProvider.credential] and there is no user corresponding to the given email.",
        );
      case "wrong-password":
        return const LogInWithCredentialFailure(
          message:
              "Thrown if signing in with a credential from [EmailAuthProvider.credential] and the password is invalid for the given email, or if the account corresponding to the email does not have a password set.",
        );
      case "invalid-verification-code":
        return const LogInWithCredentialFailure(
          message:
              "Thrown if the credential is a [PhoneAuthProvider.credential] and the verification code of the credential is not valid.",
        );
      case "invalid-verification-id":
        return const LogInWithCredentialFailure(
          message:
              "Thrown if the credential is a [PhoneAuthProvider.credential] and the verification ID of the credential is not valid.id.",
        );
      default:
        return const LogInWithCredentialFailure();
    }
  }
}

class LinkWithCredentialFailure implements Exception {
  @override
  String toString() {
    return message;
  }

  final String message;

  LinkWithCredentialFailure({
    this.message = "Unknown error.",
  });

  factory LinkWithCredentialFailure.fromCode(String code) {
    String msg = "";
    switch (code) {
      case "provider-already-linked":
        msg = "The provider has already been linked to the user.";
        break;
      case "invalid-credential":
        msg = "The provider's credential is not valid.";
        break;
      case "credential-already-in-use":
        msg = "he account corresponding to the credential already exists, "
            "or is already linked to a Firebase User.";
        break;
      default:
        msg = "Unknown error.";
    }
    return LinkWithCredentialFailure(message: msg);
  }
}
