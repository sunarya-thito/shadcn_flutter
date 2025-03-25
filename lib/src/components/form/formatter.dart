import 'dart:math';

import 'package:flutter/services.dart';


TextSelection contraintToNewText(
    TextEditingValue oldValue, TextEditingValue newValue) {
  return TextSelection(
    baseOffset: newValue.selection.baseOffset.clamp(0, newValue.text.length),
    extentOffset:
        newValue.selection.extentOffset.clamp(0, newValue.text.length),
  );
}

class TextInputFormatters {
  static const TextInputFormatter toUpperCase = _ToUpperCaseTextFormatter();
  static const TextInputFormatter toLowerCase = _ToLowerCaseTextFormatter();
  static TextInputFormatter time({required int length}) {
    return _TimeFormatter(length: length);
  }

  static TextInputFormatter integerOnly({int? min, int? max}) {
    return _IntegerOnlyFormatter(min: min, max: max);
  }

  const TextInputFormatters._();
}

class _TimeFormatter extends TextInputFormatter {
  final int length;
  const _TimeFormatter({required this.length});
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // make sure new value has leading zero
    var newText = newValue.text;
    int substringCount = 0;
    if (newText.length > length) {
      substringCount = newText.length - length;
      newText = newText.substring(substringCount);
    }
    int padLength = length - newText.length;
    var baseOffset2 = newValue.selection.baseOffset;
    var extentOffset2 = newValue.selection.extentOffset;
    if (padLength > 0) {
      newText = newText.padLeft(length, '0');
      baseOffset2 = baseOffset2 + padLength;
      extentOffset2 = extentOffset2 + padLength;
    }
    return newValue.copyWith(
      text: newText,
      composing: newValue.composing.isValid
          ? TextRange(
              start: newValue.composing.start
                  .clamp(0, min(length, newValue.text.length)),
              end: newValue.composing.end
                  .clamp(0, min(length, newValue.text.length)),
            )
          : newValue.composing,
      selection: TextSelection(
        baseOffset: baseOffset2.clamp(0, min(length, newText.length)),
        extentOffset: extentOffset2.clamp(0, min(length, newText.length)),
      ),
    );
  }
}

class _IntegerOnlyFormatter extends TextInputFormatter {
  final int? min;
  final int? max;

  _IntegerOnlyFormatter({this.min, this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    int? value = int.tryParse(newValue.text);
    if (value == null) {
      return oldValue;
    }
    if (min != null && value < min!) {
      value = min!;
    }
    if (max != null && value > max!) {
      value = max!;
    }
    var newText = value.toString();
    return TextEditingValue(
      text: newText,
      selection: contraintToNewText(oldValue, newValue),
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
