import 'package:formz/formz.dart';

enum IntegerInputError { negative, empty }

class IntegerInput extends FormzInput<int, IntegerInputError> {
  const IntegerInput.pure() : super.pure(0);
  const IntegerInput.dirty({required int value}) : super.dirty(value);

  @override
  IntegerInputError? validator(int value) {
    if (value < 0) return IntegerInputError.negative;
    return null;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == IntegerInputError.empty) return 'Required';
    if (displayError == IntegerInputError.negative) {
      return 'Should be greater or equal to 0';
    }

    return null;
  }
}
