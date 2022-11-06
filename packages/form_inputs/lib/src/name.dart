import 'package:formz/formz.dart';

/// Validation errors for the [Price] [FormzInput].
enum NameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template email}
/// Form input for an email input.
/// {@endtemplate}
class Name extends FormzInput<String, NameValidationError> {
  /// {@macro email}
  const Name.pure() : super.pure('');

  /// {@macro email}
  const Name.dirty([super.value = '']) : super.dirty();

  static final RegExp _nameRegExp = RegExp(
    r'^[a-zA-Z0-9\u00C0-\u017F]+(?: [a-zA-Z0-9\u00C0-\u017F]+)*$',
  );

  @override
  NameValidationError? validator(String? value) {
    return _nameRegExp.hasMatch(value ?? '')
        ? null
        : NameValidationError.invalid;
  }
}