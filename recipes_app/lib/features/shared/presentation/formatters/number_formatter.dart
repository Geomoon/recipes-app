import 'package:flutter/services.dart';

class NumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // final pattern = RegExp(r'\D');
    // print(pattern.hasMatch(newValue.text));

    final text =
        newValue.text.replaceAll(',', '.').replaceAll(RegExp(r'\D'), '');
    final hasManyPoints = text.indexOf('.') != text.lastIndexOf('.');

    if (hasManyPoints) {
      return oldValue;
    }

    return newValue;
  }
}
