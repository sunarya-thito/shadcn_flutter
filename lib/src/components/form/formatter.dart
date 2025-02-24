import 'package:flutter/services.dart';

class TextInputFormatters {
  static const TextInputFormatter toUpperCase = _ToUpperCaseTextFormatter();
  static const TextInputFormatter toLowerCase = _ToLowerCaseTextFormatter();
  static const TextInputFormatter digitsOnly = _DigitsOnlyTextFormatter();
  const TextInputFormatters._();
}

class _DigitsOnlyTextFormatter extends TextInputFormatter {
  const _DigitsOnlyTextFormatter();
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.replaceAll(RegExp(r'\D'), ''),
      selection: newValue.selection,
    );
  }
}

class _ToUpperCaseTextFormatter extends TextInputFormatter {
  const _ToUpperCaseTextFormatter();
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class _ToLowerCaseTextFormatter extends TextInputFormatter {
  const _ToLowerCaseTextFormatter();
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}
