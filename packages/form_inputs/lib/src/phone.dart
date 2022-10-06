import 'package:formz/formz.dart';

/// phone errors
enum PhoneValidationError {
  /// invalide phone number
  invalid;
}

///
class Phone extends FormzInput<String, PhoneValidationError> {
  ///
  const Phone.dirty([super.value = '']) : super.dirty();
  const Phone.pure() : super.pure('');
  static final RegExp _phoneRegExp = RegExp(
    r'^(\+213)?0[657][0-9]{8}$',
  );
  @override
  PhoneValidationError? validator(String value) {
    return _phoneRegExp.hasMatch(value) ? null : PhoneValidationError.invalid;
  }
}
