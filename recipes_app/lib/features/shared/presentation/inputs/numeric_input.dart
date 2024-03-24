import 'package:formz/formz.dart';

enum NumericInputError { negative }

class NumericInput extends FormzInput<double, NumericInputError> {
  const NumericInput.pure({double value = 0}) : super.pure(value);
  const NumericInput.dirty({required double value}) : super.dirty(value);

  @override
  NumericInputError? validator(double value) {
    if (value < 0) return NumericInputError.negative;
    return null;
  }

  String? get errorMessage {
    if (error == NumericInputError.negative) return "Greater or equal to 0";
    return null;
  }
}
