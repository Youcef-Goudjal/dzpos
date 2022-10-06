import 'package:formz/formz.dart';

/// errors return values
enum CodeError {
  /// when the code is empty
  empty;

  ///
  String get name => toString().split('.').last;
}

class Code extends FormzInput<String, CodeError> {
  const Code.dirty([super.value = '']) : super.dirty();
  const Code.pure() : super.pure('');

  @override
  CodeError? validator(String value) {
    return (value.isEmpty) ? CodeError.empty : null;
  }
}
