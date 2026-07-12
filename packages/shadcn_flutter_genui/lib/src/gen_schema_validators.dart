import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_genui/src/gen_schema.dart';

/// AI-selectable [GenValidator] kinds, each backed by one of
/// shadcn_flutter's own [Validator] implementations. Built on this
/// package's own [GenValidator] contract (declared via
/// [GenDataFieldDescriptor], never a raw JSON schema), not genui's
/// validation primitives.
class GenNotEmptyValidator extends GenValidator<String> {
  GenNotEmptyValidator();
  late GenDataField<String?> message;

  @override
  String get kind => 'notEmpty';
  @override
  void describeFields(GenDataFieldDescriptor descriptor) {
    message = descriptor.optionalString(
      'message',
      label: 'Error message shown when empty',
    );
  }

  @override
  Validator<String> build() => NotEmptyValidator(message: message.value);
}

class GenLengthValidator extends GenValidator<String> {
  GenLengthValidator();
  late GenDataField<int?> min;
  late GenDataField<int?> max;
  late GenDataField<String?> message;

  @override
  String get kind => 'length';
  @override
  void describeFields(GenDataFieldDescriptor descriptor) {
    min = descriptor.optionalInteger('min', label: 'Minimum length');
    max = descriptor.optionalInteger('max', label: 'Maximum length');
    message = descriptor.optionalString('message', label: 'Error message');
  }

  @override
  Validator<String> build() =>
      LengthValidator(min: min.value, max: max.value, message: message.value);
}

class GenRegexValidator extends GenValidator<String> {
  GenRegexValidator();
  late GenDataField<String> pattern;
  late GenDataField<String?> message;

  @override
  String get kind => 'regex';
  @override
  void describeFields(GenDataFieldDescriptor descriptor) {
    pattern = descriptor.string('pattern', label: 'Regular expression pattern');
    message = descriptor.optionalString('message', label: 'Error message');
  }

  @override
  Validator<String> build() =>
      RegexValidator(RegExp(pattern.value), message: message.value);
}

class GenEmailValidator extends GenValidator<String> {
  GenEmailValidator();
  late GenDataField<String?> message;

  @override
  String get kind => 'email';
  @override
  void describeFields(GenDataFieldDescriptor descriptor) {
    message = descriptor.optionalString('message', label: 'Error message');
  }

  @override
  Validator<String> build() => EmailValidator(message: message.value);
}

class GenUrlValidator extends GenValidator<String> {
  GenUrlValidator();
  late GenDataField<String?> message;

  @override
  String get kind => 'url';
  @override
  void describeFields(GenDataFieldDescriptor descriptor) {
    message = descriptor.optionalString('message', label: 'Error message');
  }

  @override
  Validator<String> build() => URLValidator(message: message.value);
}

class GenRangeValidator<T extends num> extends GenValidator<T> {
  GenRangeValidator();
  late GenDataField<double> min;
  late GenDataField<double> max;
  late GenDataField<bool?> inclusive;
  late GenDataField<String?> message;

  @override
  String get kind => 'range';
  @override
  void describeFields(GenDataFieldDescriptor descriptor) {
    min = descriptor.decimal('min', label: 'Minimum value');
    max = descriptor.decimal('max', label: 'Maximum value');
    inclusive = descriptor.optionalBoolean(
      'inclusive',
      label: 'Whether the bounds themselves are acceptable',
    );
    message = descriptor.optionalString('message', label: 'Error message');
  }

  @override
  Validator<T> build() => RangeValidator<T>(
    _numAs<T>(min.value),
    _numAs<T>(max.value),
    inclusive: inclusive.value ?? true,
    message: message.value,
  );
}

class GenNonNullValidator<T> extends GenValidator<T> {
  GenNonNullValidator();
  late GenDataField<String?> message;

  @override
  String get kind => 'required';
  @override
  void describeFields(GenDataFieldDescriptor descriptor) {
    message = descriptor.optionalString(
      'message',
      label: 'Error message shown when missing',
    );
  }

  @override
  Validator<T> build() => NonNullValidator<T>(message: message.value);
}

T _numAs<T extends num>(double value) =>
    (T == int ? value.round() : value) as T;
