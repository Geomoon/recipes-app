final class NumericValidator {
  static String? validate(String? input) {
    if (input == null) return null;
    final value = double.tryParse(input);
    if (value == null) return 'invalid';
    return null;
  }
}
