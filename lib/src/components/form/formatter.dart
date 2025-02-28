import 'package:flutter/services.dart';

import '../../../shadcn_flutter.dart';

class TextInputFormatters {
  static const TextInputFormatter toUpperCase = _ToUpperCaseTextFormatter();
  static const TextInputFormatter toLowerCase = _ToLowerCaseTextFormatter();
  static const TextInputFormatter digitsOnly = _DigitsOnlyTextFormatter();
  static TextInputFormatter datePart(Map<DatePart, int> values, DatePart part) {
    return _DatePartFormatter(values, part);
  }

  const TextInputFormatters._();
}

class _DatePartFormatter extends TextInputFormatter {
  final Map<DatePart, int> values;
  final DatePart part;

  _DatePartFormatter(this.values, this.part);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    final (int? min, int? max) = part.computeValueRange(values);
    int? value = int.tryParse(newValue.text);
    if (value == null) {
      return oldValue;
    }
    if (min != null && value < min) {
      value = min;
    }
    if (max != null && value > max) {
      value = max;
    }
    return TextEditingValue(
      text: value.toString(),
      selection: newValue.selection,
    );
  }
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
