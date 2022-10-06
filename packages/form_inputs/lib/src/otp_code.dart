import 'package:formz/formz.dart';

/// error when verifying otp code
enum OTPCodeErrors {
  /// if the code is empty
  empty,

  /// if the code contain chars not numbers
  /// only numbers allowed
  notNumbers,

  /// if the code is > than 6
  max6L;
}

///
class OTPCode extends FormzInput<String, OTPCodeErrors> {
  ///
  const OTPCode.dirty([super.value = '']) : super.dirty();
  const OTPCode.pure() : super.pure('');
  static final RegExp _OTPRegExp = RegExp(
    '^[0-9]+',
  );
  @override
  OTPCodeErrors? validator(String value) {
    if (value.isEmpty) return OTPCodeErrors.empty;
    if (!_OTPRegExp.hasMatch(value)) return OTPCodeErrors.notNumbers;
    if (value.length > 6) return OTPCodeErrors.max6L;

    return null;
  }
}
