import 'package:formz/formz.dart';

/// class that validate username
class Username extends FormzInput<String, UsernameError> {
  ///
  const Username.pure([super.value = '']) : super.pure();

  ///
  const Username.dirty([super.value = '']) : super.dirty();

  @override
  UsernameError? validator(String value) {
    return value.isEmpty ? UsernameError.empty : null;
  }
}

/// when the user is [empty]
enum UsernameError {
  /// value == ""
  empty
}
