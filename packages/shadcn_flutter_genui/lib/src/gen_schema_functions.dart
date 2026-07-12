import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter_genui/src/gen_schema.dart';

/// Arithmetic/string/boolean [GenSystemFunction]s, complementing genui's
/// own `BasicFunctions` (`and`/`or`/`not`/`required`/`regex`/...). Built on
/// this package's own [GenSystemFunction] contract, not genui's
/// `ClientFunction` directly, so they're reachable both by the AI directly
/// and from a widget's `functionCall` action nodes, exactly like any
/// developer-provided system function.
abstract final class GenFunctions {
  GenFunctions._();

  static final add = AddFunction();
  static final subtract = SubtractFunction();
  static final multiply = MultiplyFunction();
  static final divide = DivideFunction();
  static final floor = FloorFunction();
  static final ceil = CeilFunction();
  static final round = RoundFunction();
  static final sin = SinFunction();
  static final cos = CosFunction();
  static final clamp = ClampFunction();
  static final concat = ConcatFunction();
  static final trim = TrimFunction();
  static final substring = SubstringFunction();
  static final toUpperCase = ToUpperCaseFunction();
  static final toLowerCase = ToLowerCaseFunction();
  static final xor = XorFunction();

  static List<GenSystemFunction> get all => [
    add,
    subtract,
    multiply,
    divide,
    floor,
    ceil,
    round,
    sin,
    cos,
    clamp,
    concat,
    trim,
    substring,
    toUpperCase,
    toLowerCase,
    xor,
  ];
}

class AddFunction extends GenSystemFunction {
  late GenDataField<double> a;
  late GenDataField<double> b;

  @override
  String get name => 'add';
  @override
  String get description => 'Adds two numbers: a + b.';
  @override
  void describeFields(GenDataFieldDescriptor descriptor) {
    a = descriptor.decimal('a', label: 'First number');
    b = descriptor.decimal('b', label: 'Second number');
  }

  @override
  Future<Object?> invoke([BuildContext? context]) async => a.value + b.value;
}

class SubtractFunction extends GenSystemFunction {
  late GenDataField<double> a;
  late GenDataField<double> b;

  @override
  String get name => 'subtract';
  @override
  String get description => 'Subtracts two numbers: a - b.';
  @override
  void describeFields(GenDataFieldDescriptor descriptor) {
    a = descriptor.decimal('a', label: 'First number');
    b = descriptor.decimal('b', label: 'Second number');
  }

  @override
  Future<Object?> invoke([BuildContext? context]) async => a.value - b.value;
}

class MultiplyFunction extends GenSystemFunction {
  late GenDataField<double> a;
  late GenDataField<double> b;

  @override
  String get name => 'multiply';
  @override
  String get description => 'Multiplies two numbers: a * b.';
  @override
  void describeFields(GenDataFieldDescriptor descriptor) {
    a = descriptor.decimal('a', label: 'First number');
    b = descriptor.decimal('b', label: 'Second number');
  }

  @override
  Future<Object?> invoke([BuildContext? context]) async => a.value * b.value;
}

class DivideFunction extends GenSystemFunction {
  late GenDataField<double> a;
  late GenDataField<double> b;

  @override
  String get name => 'divide';
  @override
  String get description => 'Divides two numbers: a / b.';
  @override
  void describeFields(GenDataFieldDescriptor descriptor) {
    a = descriptor.decimal('a', label: 'First number');
    b = descriptor.decimal('b', label: 'Second number');
  }

  @override
  Future<Object?> invoke([BuildContext? context]) async => a.value / b.value;
}

class FloorFunction extends GenSystemFunction {
  late GenDataField<double> value;

  @override
  String get name => 'floor';
  @override
  String get description => 'Rounds a number down to the nearest integer.';
  @override
  void describeFields(GenDataFieldDescriptor descriptor) {
    value = descriptor.decimal('value', label: 'Value');
  }

  @override
  Future<Object?> invoke([BuildContext? context]) async => value.value.floor();
}

class CeilFunction extends GenSystemFunction {
  late GenDataField<double> value;

  @override
  String get name => 'ceil';
  @override
  String get description => 'Rounds a number up to the nearest integer.';
  @override
  void describeFields(GenDataFieldDescriptor descriptor) {
    value = descriptor.decimal('value', label: 'Value');
  }

  @override
  Future<Object?> invoke([BuildContext? context]) async => value.value.ceil();
}

class RoundFunction extends GenSystemFunction {
  late GenDataField<double> value;
  late GenDataField<int?> decimals;

  @override
  String get name => 'round';
  @override
  String get description =>
      'Rounds a number to the nearest integer, or to the given number of '
      'decimal places.';
  @override
  void describeFields(GenDataFieldDescriptor descriptor) {
    value = descriptor.decimal('value', label: 'Value');
    decimals = descriptor.optionalInteger('decimals', label: 'Decimal places');
  }

  @override
  Future<Object?> invoke([BuildContext? context]) async {
    final factor = math.pow(10, decimals.value ?? 0);
    return (value.value * factor).round() / factor;
  }
}

class SinFunction extends GenSystemFunction {
  late GenDataField<double> value;

  @override
  String get name => 'sin';
  @override
  String get description => 'The sine of a number, in radians.';
  @override
  void describeFields(GenDataFieldDescriptor descriptor) {
    value = descriptor.decimal('value', label: 'Value, in radians');
  }

  @override
  Future<Object?> invoke([BuildContext? context]) async => math.sin(value.value);
}

class CosFunction extends GenSystemFunction {
  late GenDataField<double> value;

  @override
  String get name => 'cos';
  @override
  String get description => 'The cosine of a number, in radians.';
  @override
  void describeFields(GenDataFieldDescriptor descriptor) {
    value = descriptor.decimal('value', label: 'Value, in radians');
  }

  @override
  Future<Object?> invoke([BuildContext? context]) async => math.cos(value.value);
}

class ClampFunction extends GenSystemFunction {
  late GenDataField<double> value;
  late GenDataField<double> min;
  late GenDataField<double> max;

  @override
  String get name => 'clamp';
  @override
  String get description => 'Clamps a number between a minimum and maximum.';
  @override
  void describeFields(GenDataFieldDescriptor descriptor) {
    value = descriptor.decimal('value', label: 'Value');
    min = descriptor.decimal('min', label: 'Minimum');
    max = descriptor.decimal('max', label: 'Maximum');
  }

  @override
  Future<Object?> invoke([BuildContext? context]) async =>
      value.value.clamp(min.value, max.value);
}

class ConcatFunction extends GenSystemFunction {
  late GenDataField<List<String>> values;

  @override
  String get name => 'concat';
  @override
  String get description => 'Concatenates a list of strings into one.';
  @override
  void describeFields(GenDataFieldDescriptor descriptor) {
    values = descriptor.list(
      'values',
      label: 'Values to concatenate',
      item: descriptor.string('valueItem', label: 'Value'),
    );
  }

  @override
  Future<Object?> invoke([BuildContext? context]) async => values.value.join();
}

class TrimFunction extends GenSystemFunction {
  late GenDataField<String> value;

  @override
  String get name => 'trim';
  @override
  String get description => 'Removes leading and trailing whitespace.';
  @override
  void describeFields(GenDataFieldDescriptor descriptor) {
    value = descriptor.string('value', label: 'Value');
  }

  @override
  Future<Object?> invoke([BuildContext? context]) async => value.value.trim();
}

class SubstringFunction extends GenSystemFunction {
  late GenDataField<String> value;
  late GenDataField<int> start;
  late GenDataField<int?> end;

  @override
  String get name => 'substring';
  @override
  String get description => 'Extracts a substring, from [start] to [end].';
  @override
  void describeFields(GenDataFieldDescriptor descriptor) {
    value = descriptor.string('value', label: 'Value');
    start = descriptor.integer('start', label: 'Start index');
    end = descriptor.optionalInteger('end', label: 'End index');
  }

  @override
  Future<Object?> invoke([BuildContext? context]) async {
    final text = value.value;
    final startIndex = start.value.clamp(0, text.length);
    final endIndex = (end.value ?? text.length).clamp(startIndex, text.length);
    return text.substring(startIndex, endIndex);
  }
}

class ToUpperCaseFunction extends GenSystemFunction {
  late GenDataField<String> value;

  @override
  String get name => 'toUpperCase';
  @override
  String get description => 'Converts a string to upper case.';
  @override
  void describeFields(GenDataFieldDescriptor descriptor) {
    value = descriptor.string('value', label: 'Value');
  }

  @override
  Future<Object?> invoke([BuildContext? context]) async =>
      value.value.toUpperCase();
}

class ToLowerCaseFunction extends GenSystemFunction {
  late GenDataField<String> value;

  @override
  String get name => 'toLowerCase';
  @override
  String get description => 'Converts a string to lower case.';
  @override
  void describeFields(GenDataFieldDescriptor descriptor) {
    value = descriptor.string('value', label: 'Value');
  }

  @override
  Future<Object?> invoke([BuildContext? context]) async =>
      value.value.toLowerCase();
}

class XorFunction extends GenSystemFunction {
  late GenDataField<bool> a;
  late GenDataField<bool> b;

  @override
  String get name => 'xor';
  @override
  String get description => 'Performs a logical XOR of two boolean values.';
  @override
  void describeFields(GenDataFieldDescriptor descriptor) {
    a = descriptor.boolean('a', label: 'First value');
    b = descriptor.boolean('b', label: 'Second value');
  }

  @override
  Future<Object?> invoke([BuildContext? context]) async => a.value ^ b.value;
}
