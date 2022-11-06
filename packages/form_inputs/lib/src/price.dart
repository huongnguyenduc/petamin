import 'package:formz/formz.dart';

/// Validation errors for the [Price] [FormzInput].
enum PriceValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template email}
/// Form input for an email input.
/// {@endtemplate}
class Price extends FormzInput<String, PriceValidationError> {
  /// {@macro email}
  const Price.pure() : super.pure('');

  /// {@macro email}
  const Price.dirty([super.value = '']) : super.dirty();

  static final RegExp _priceRegExp = RegExp(
    r'^\d+(,\d{1,2})?',
  );

  @override
  PriceValidationError? validator(String? value) {
    return _priceRegExp.hasMatch(value ?? '')
        ? null
        : PriceValidationError.invalid;
  }
}