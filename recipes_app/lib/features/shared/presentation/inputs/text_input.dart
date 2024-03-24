import 'package:formz/formz.dart';

enum TextInputError { empty }

class TextInput extends FormzInput<String, TextInputError> {
  const TextInput.pure() : super.pure('');
  const TextInput.dirty([super.value = '']) : super.dirty();

  @override
  TextInputError? validator(String value) {
    if (value.isEmpty) return TextInputError.empty;
    return null;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (error == TextInputError.empty) {
      return 'Required';
    }
    return null;
  }
}
