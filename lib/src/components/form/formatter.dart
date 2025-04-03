import 'dart:math';

import 'package:expressions/expressions.dart';
import 'package:flutter/services.dart';

TextSelection contraintToNewText(TextEditingValue newValue, String newText) {
  return TextSelection(
    baseOffset: newValue.selection.baseOffset.clamp(0, newText.length),
    extentOffset: newValue.selection.extentOffset.clamp(0, newText.length),
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

  static TextInputFormatter digitsOnly(
      {double? min, double? max, int? decimalDigits}) {
    return _DoubleOnlyFormatter(
        min: min, max: max, decimalDigits: decimalDigits);
  }

  static TextInputFormatter mathExpression({Map<String, dynamic>? context}) {
    return _MathExpressionFormatter(context: context);
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
    String newText = newValue.text;
    if (newText.isEmpty) {
      return newValue;
    }
    bool negate = newText.startsWith('-');
    if (negate) {
      newText = newText.substring(1);
    }
    int? value = int.tryParse(newText);
    if (value == null) {
      if (negate) {
        return const TextEditingValue(
          text: '-',
          selection: TextSelection.collapsed(offset: 1),
        );
      }
      return oldValue;
    }
    if (min != null && value <= min!) {
      value = min!;
    }
    if (max != null && value >= max!) {
      value = max!;
    }
    newText = value.toString();
    if (negate) {
      newText = '-$newText';
    }
    return TextEditingValue(
      text: newText,
      selection: contraintToNewText(newValue, newText),
    );
  }
}

class _DoubleOnlyFormatter extends TextInputFormatter {
  final double? min;
  final double? max;
  final int? decimalDigits;

  _DoubleOnlyFormatter({this.min, this.max, this.decimalDigits});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;
    if (newText.isEmpty) {
      return newValue;
    }
    bool negate = newText.startsWith('-');
    if (negate) {
      newText = newText.substring(1);
    }
    bool endsWithDot = newText.endsWith('.');
    if (endsWithDot) {
      newText = newText.substring(0, newText.length - 1);
    }
    double? value = double.tryParse(newText);
    if (value == null) {
      if (negate) {
        return const TextEditingValue(
          text: '-',
          selection: TextSelection.collapsed(offset: 1),
        );
      }
      return oldValue;
    }
    if (min != null && value <= min!) {
      value = min!;
      endsWithDot = false;
    }
    if (max != null && value >= max!) {
      value = max!;
      endsWithDot = false;
    }
    // var newText = value.toString();
    if (decimalDigits != null) {
      newText = value.toStringAsFixed(decimalDigits!);
    } else {
      newText = value.toString();
    }
    if (newText.contains('.')) {
      while (newText.endsWith('0')) {
        newText = newText.substring(0, newText.length - 1);
      }
      if (newText.endsWith('.')) {
        newText = newText.substring(0, newText.length - 1);
      }
    }
    if (endsWithDot) {
      newText += '.';
    }
    if (negate) {
      newText = '-$newText';
    }
    return TextEditingValue(
      text: newText,
      selection: contraintToNewText(newValue, newText),
    );
  }
}

class _MathExpressionFormatter extends TextInputFormatter {
  final Map<String, dynamic>? context;
  const _MathExpressionFormatter({this.context});
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;
    Object? result;
    try {
      Expression expression = Expression.parse(newText);
      ExpressionEvaluator evaluator = const ExpressionEvaluator();
      result = evaluator.eval(expression, context ?? {});
      if (result is! num) {
        result = '';
      }
    } catch (e) {
      result = '';
    }
    String resultText = result.toString();
    if (resultText.contains('.')) {
      while (resultText.endsWith('0')) {
        resultText = resultText.substring(0, resultText.length - 1);
      }
      if (resultText.endsWith('.')) {
        resultText = resultText.substring(0, resultText.length - 1);
      }
    }
    return TextEditingValue(
      text: resultText,
      selection: contraintToNewText(newValue, resultText),
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
