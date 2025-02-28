import 'dart:async';

import 'package:email_validator/email_validator.dart' as email_validator;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' as widgets;

import '../../../shadcn_flutter.dart';

abstract class Validator<T> {
  const Validator();
  FutureOr<ValidationResult?> validate(
      BuildContext context, T? value, FormValidationMode lifecycle);

  Validator<T> combine(Validator<T> other) {
    return CompositeValidator([this, other]);
  }

  Validator<T> operator &(Validator<T> other) {
    return combine(other);
  }

  Validator<T> operator |(Validator<T> other) {
    return OrValidator([this, other]);
  }

  Validator<T> operator ~() {
    return NotValidator(this);
  }

  Validator<T> operator -() {
    return NotValidator(this);
  }

  Validator<T> operator +(Validator<T> other) {
    return combine(other);
  }

  bool shouldRevalidate(FormKey<dynamic> source) => false;
}

enum FormValidationMode {
  initial,
  changed,
  submitted,
  waiting,
}

class ValidationMode<T> extends Validator<T> {
  final Validator<T> validator;
  final Set<FormValidationMode> mode;

  const ValidationMode(this.validator,
      {this.mode = const {
        FormValidationMode.changed,
        FormValidationMode.submitted,
        FormValidationMode.initial
      }});

  @override
  FutureOr<ValidationResult?> validate(
      BuildContext context, T? value, FormValidationMode lifecycle) {
    if (this.mode.contains(lifecycle)) {
      return validator.validate(context, value, lifecycle);
    }
    return null;
  }

  @override
  operator ==(Object other) {
    return other is ValidationMode &&
        other.validator == validator &&
        other.mode == mode;
  }

  @override
  int get hashCode => Object.hash(validator, mode);
}

typedef FuturePredicate<T> = FutureOr<bool> Function(T? value);

/// This widget prevents form components from submitting its value to the form controller
class IgnoreForm<T> extends StatelessWidget {
  final bool ignoring;
  final Widget child;

  const IgnoreForm({this.ignoring = true, required this.child});

  @override
  widgets.Widget build(widgets.BuildContext context) {
    return MultiData(
      data: ignoring
          ? const [
              Data<FormFieldHandle>.boundary(),
              Data<FormController>.boundary(),
            ]
          : const [],
      child: child,
    );
  }
}

class ConditionalValidator<T> extends Validator<T> {
  final FuturePredicate<T> predicate;
  final String message;
  final List<FormKey> dependencies;

  const ConditionalValidator(this.predicate,
      {required this.message, this.dependencies = const []});

  @override
  FutureOr<ValidationResult?> validate(
      BuildContext context, T? value, FormValidationMode lifecycle) {
    var result = predicate(value);
    if (result is Future<bool>) {
      return result.then((value) {
        if (!value) {
          return InvalidResult(message, state: lifecycle);
        }
        return null;
      });
    } else if (!result) {
      return InvalidResult(message, state: lifecycle);
    }

    return null;
  }

  @override
  bool shouldRevalidate(FormKey<dynamic> source) {
    return dependencies.contains(source);
  }

  @override
  operator ==(Object other) {
    return other is ConditionalValidator &&
        other.predicate == predicate &&
        other.message == message;
  }

  @override
  int get hashCode => Object.hash(predicate, message);
}

typedef ValidatorBuilderFunction<T> = FutureOr<ValidationResult?> Function(
    T? value);

class ValidatorBuilder<T> extends Validator<T> {
  final ValidatorBuilderFunction<T> builder;
  final List<FormKey> dependencies;

  const ValidatorBuilder(this.builder, {this.dependencies = const []});

  @override
  FutureOr<ValidationResult?> validate(
      BuildContext context, T? value, FormValidationMode lifecycle) {
    return builder(value);
  }

  @override
  bool shouldRevalidate(FormKey<dynamic> source) {
    return dependencies.contains(source);
  }

  @override
  operator ==(Object other) {
    return other is ValidatorBuilder && other.builder == builder;
  }

  @override
  int get hashCode => builder.hashCode;
}

class NotValidator<T> extends Validator<T> {
  final Validator<T> validator;
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const NotValidator(this.validator, {this.message});

  @override
  FutureOr<ValidationResult?> validate(
      BuildContext context, T? value, FormValidationMode state) {
    var localizations = Localizations.of(context, ShadcnLocalizations);
    var result = validator.validate(context, value, state);
    if (result is Future<ValidationResult?>) {
      return result.then((value) {
        if (value == null) {
          return InvalidResult(message ?? localizations.invalidValue,
              state: state);
        }
        return null;
      });
    } else if (result == null) {
      return InvalidResult(message ?? localizations.invalidValue, state: state);
    }
    return null;
  }

  @override
  operator ==(Object other) {
    return other is NotValidator &&
        other.validator == validator &&
        other.message == message;
  }

  @override
  int get hashCode => Object.hash(validator, message);
}

class OrValidator<T> extends Validator<T> {
  final List<Validator<T>> validators;

  const OrValidator(this.validators);

  @override
  FutureOr<ValidationResult?> validate(
      BuildContext context, T? value, FormValidationMode state) {
    return _chainedValidation(context, value, state, 0);
  }

  FutureOr<ValidationResult?> _chainedValidation(
      BuildContext context, T? value, FormValidationMode state, int index) {
    if (index >= validators.length) {
      return null;
    }
    var validator = validators[index];
    var result = validator.validate(context, value, state);
    if (result is Future<ValidationResult?>) {
      return result.then((nextValue) {
        if (nextValue == null) {
          // means one of the validators passed and we don't need to check the rest
          return null;
        }
        if (!context.mounted) {
          return null;
        }
        return _chainedValidation(context, value, state, index + 1);
      });
    } else if (result == null) {
      // means one of the validators passed and we don't need to check the rest
      return null;
    }
    return _chainedValidation(context, value, state, index + 1);
  }

  @override
  Validator<T> operator |(Validator<T> other) {
    return OrValidator([...validators, other]);
  }

  @override
  bool shouldRevalidate(FormKey<dynamic> source) {
    for (var validator in validators) {
      if (validator.shouldRevalidate(source)) {
        return true;
      }
    }
    return false;
  }

  @override
  operator ==(Object other) {
    return other is OrValidator && listEquals(other.validators, validators);
  }

  @override
  int get hashCode => validators.hashCode;
}

class NonNullValidator<T> extends Validator<T> {
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const NonNullValidator({this.message});

  @override
  FutureOr<ValidationResult?> validate(
      BuildContext context, T? value, FormValidationMode state) {
    if (value == null) {
      var localizations = Localizations.of(context, ShadcnLocalizations);
      return InvalidResult(message ?? localizations.formNotEmpty, state: state);
    }
    return null;
  }

  @override
  bool operator ==(Object other) {
    return other is NonNullValidator && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class NotEmptyValidator extends NonNullValidator<String> {
  const NotEmptyValidator({super.message});

  @override
  FutureOr<ValidationResult?> validate(
      BuildContext context, String? value, FormValidationMode state) {
    if (value == null || value.isEmpty) {
      var localizations = Localizations.of(context, ShadcnLocalizations);
      return InvalidResult(message ?? localizations.formNotEmpty, state: state);
    }
    return null;
  }

  @override
  bool operator ==(Object other) {
    return other is NotEmptyValidator && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class LengthValidator extends Validator<String> {
  final int? min;
  final int? max;
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const LengthValidator({this.min, this.max, this.message});

  @override
  FutureOr<ValidationResult?> validate(
      BuildContext context, String? value, FormValidationMode state) {
    if (value == null) {
      return null;
    }
    ShadcnLocalizations localizations =
        Localizations.of(context, ShadcnLocalizations);
    if (min != null && value.length < min!) {
      return InvalidResult(message ?? localizations.formLengthLessThan(min!),
          state: state);
    }
    if (max != null && value.length > max!) {
      return InvalidResult(message ?? localizations.formLengthGreaterThan(max!),
          state: state);
    }
    return null;
  }

  @override
  bool operator ==(Object other) {
    return other is LengthValidator &&
        other.min == min &&
        other.max == max &&
        other.message == message;
  }

  @override
  int get hashCode => Object.hash(min, max, message);
}

enum CompareType { greater, greaterOrEqual, less, lessOrEqual, equal }

class CompareWith<T extends Comparable<T>> extends Validator<T> {
  final FormKey<T> key;
  final CompareType type;
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const CompareWith(this.key, this.type, {this.message});
  const CompareWith.equal(this.key, {this.message}) : type = CompareType.equal;
  const CompareWith.greater(this.key, {this.message})
      : type = CompareType.greater;
  const CompareWith.greaterOrEqual(this.key, {this.message})
      : type = CompareType.greaterOrEqual;
  const CompareWith.less(this.key, {this.message}) : type = CompareType.less;
  const CompareWith.lessOrEqual(this.key, {this.message})
      : type = CompareType.lessOrEqual;

  int _compare(T? a, T? b) {
    if (a == null && b == null) {
      return 0;
    }
    if (a == null) {
      return -1;
    }
    if (b == null) {
      return 1;
    }
    return a.compareTo(b);
  }

  @override
  FutureOr<ValidationResult?> validate(
      BuildContext context, T? value, FormValidationMode state) {
    var localizations = Localizations.of(context, ShadcnLocalizations);
    var otherValue = context.getFormValue(key);
    if (otherValue == null) {
      return InvalidResult(message ?? localizations.invalidValue, state: state);
    }
    var compare = _compare(value, otherValue);
    switch (type) {
      case CompareType.greater:
        if (compare <= 0) {
          return InvalidResult(
              message ?? localizations.formGreaterThan(otherValue),
              state: state);
        }
        break;
      case CompareType.greaterOrEqual:
        if (compare < 0) {
          return InvalidResult(
              message ?? localizations.formGreaterThanOrEqualTo(otherValue),
              state: state);
        }
        break;
      case CompareType.less:
        if (compare >= 0) {
          return InvalidResult(
              message ?? localizations.formLessThan(otherValue),
              state: state);
        }
        break;
      case CompareType.lessOrEqual:
        if (compare > 0) {
          return InvalidResult(
              message ?? localizations.formLessThanOrEqualTo(otherValue),
              state: state);
        }
        break;
      case CompareType.equal:
        if (compare != 0) {
          return InvalidResult(message ?? localizations.formEqualTo(otherValue),
              state: state);
        }
        break;
    }
    return null;
  }

  @override
  bool shouldRevalidate(FormKey<dynamic> source) {
    return source == key;
  }

  @override
  bool operator ==(Object other) {
    return other is CompareWith &&
        other.key == key &&
        other.type == type &&
        other.message == message;
  }

  @override
  int get hashCode => Object.hash(key, type, message);
}

class SafePasswordValidator extends Validator<String> {
  final String?
      message; // if null, use default message from ShadcnLocalizations
  final bool requireDigit;
  final bool requireLowercase;
  final bool requireUppercase;
  final bool requireSpecialChar;

  const SafePasswordValidator(
      {this.requireDigit = true,
      this.requireLowercase = true,
      this.requireUppercase = true,
      this.requireSpecialChar = true,
      this.message});

  @override
  FutureOr<ValidationResult?> validate(
      BuildContext context, String? value, FormValidationMode state) {
    if (value == null) {
      return null;
    }
    if (requireDigit && !RegExp(r'\d').hasMatch(value)) {
      return InvalidResult(
          message ??
              Localizations.of(context, ShadcnLocalizations).formPasswordDigits,
          state: state);
    }
    if (requireLowercase && !RegExp(r'[a-z]').hasMatch(value)) {
      return InvalidResult(
          message ??
              Localizations.of(context, ShadcnLocalizations)
                  .formPasswordLowercase,
          state: state);
    }
    if (requireUppercase && !RegExp(r'[A-Z]').hasMatch(value)) {
      return InvalidResult(
          message ??
              Localizations.of(context, ShadcnLocalizations)
                  .formPasswordUppercase,
          state: state);
    }
    if (requireSpecialChar && !RegExp(r'[\W_]').hasMatch(value)) {
      return InvalidResult(
          message ??
              Localizations.of(context, ShadcnLocalizations)
                  .formPasswordSpecial,
          state: state);
    }
    return null;
  }

  @override
  bool operator ==(Object other) {
    return other is SafePasswordValidator &&
        other.requireDigit == requireDigit &&
        other.requireLowercase == requireLowercase &&
        other.requireUppercase == requireUppercase &&
        other.requireSpecialChar == requireSpecialChar &&
        other.message == message;
  }

  @override
  int get hashCode => Object.hash(requireDigit, requireLowercase,
      requireUppercase, requireSpecialChar, message);
}

class MinValidator<T extends num> extends Validator<T> {
  final T min;
  final bool inclusive;
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const MinValidator(this.min, {this.inclusive = true, this.message});

  @override
  FutureOr<ValidationResult?> validate(
      BuildContext context, T? value, FormValidationMode state) {
    if (value == null) {
      return null;
    }
    if (inclusive) {
      if (value < min) {
        return InvalidResult(
            message ??
                Localizations.of(context, ShadcnLocalizations)
                    .formGreaterThanOrEqualTo(min),
            state: state);
      }
    } else {
      if (value <= min) {
        return InvalidResult(
            message ??
                Localizations.of(context, ShadcnLocalizations)
                    .formGreaterThan(min),
            state: state);
      }
    }
    return null;
  }

  @override
  bool operator ==(Object other) {
    return other is MinValidator &&
        other.min == min &&
        other.inclusive == inclusive &&
        other.message == message;
  }

  @override
  int get hashCode => Object.hash(min, inclusive, message);
}

class MaxValidator<T extends num> extends Validator<T> {
  final T max;
  final bool inclusive;
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const MaxValidator(this.max, {this.inclusive = true, this.message});

  @override
  FutureOr<ValidationResult?> validate(
      BuildContext context, T? value, FormValidationMode state) {
    if (value == null) {
      return null;
    }
    if (inclusive) {
      if (value > max) {
        return InvalidResult(
            message ??
                Localizations.of(context, ShadcnLocalizations)
                    .formLessThanOrEqualTo(max),
            state: state);
      }
    } else {
      if (value >= max) {
        return InvalidResult(
            message ??
                Localizations.of(context, ShadcnLocalizations)
                    .formLessThan(max),
            state: state);
      }
    }
    return null;
  }

  @override
  bool operator ==(Object other) {
    return other is MaxValidator &&
        other.max == max &&
        other.inclusive == inclusive &&
        other.message == message;
  }

  @override
  int get hashCode => Object.hash(max, inclusive, message);
}

class RangeValidator<T extends num> extends Validator<T> {
  final T min;
  final T max;
  final bool inclusive;
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const RangeValidator(this.min, this.max,
      {this.inclusive = true, this.message});

  @override
  FutureOr<ValidationResult?> validate(
      BuildContext context, T? value, FormValidationMode state) {
    if (value == null) {
      return null;
    }
    if (inclusive) {
      if (value < min || value > max) {
        return InvalidResult(
            message ??
                Localizations.of(context, ShadcnLocalizations)
                    .formBetweenInclusively(min, max),
            state: state);
      }
    } else {
      if (value <= min || value >= max) {
        return InvalidResult(
            message ??
                Localizations.of(context, ShadcnLocalizations)
                    .formBetweenExclusively(min, max),
            state: state);
      }
    }
    return null;
  }

  @override
  bool operator ==(Object other) {
    return other is RangeValidator &&
        other.min == min &&
        other.max == max &&
        other.inclusive == inclusive &&
        other.message == message;
  }
}

class RegexValidator extends Validator<String> {
  final RegExp pattern;
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const RegexValidator(this.pattern, {this.message});

  @override
  FutureOr<ValidationResult?> validate(
      BuildContext context, String? value, FormValidationMode state) {
    if (value == null) {
      return null;
    }
    if (!pattern.hasMatch(value)) {
      return InvalidResult(
          message ??
              Localizations.of(context, ShadcnLocalizations).invalidValue,
          state: state);
    }
    return null;
  }

  @override
  bool operator ==(Object other) {
    return other is RegexValidator &&
        other.pattern == pattern &&
        other.message == message;
  }

  @override
  int get hashCode => Object.hash(pattern, message);
}

// email validator using email_validator package
class EmailValidator extends Validator<String> {
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const EmailValidator({this.message});

  @override
  FutureOr<ValidationResult?> validate(
      BuildContext context, String? value, FormValidationMode state) {
    if (value == null) {
      return null;
    }
    if (!email_validator.EmailValidator.validate(value)) {
      return InvalidResult(
          message ??
              Localizations.of(context, ShadcnLocalizations).invalidEmail,
          state: state);
    }
    return null;
  }

  @override
  bool operator ==(Object other) {
    return other is EmailValidator && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class URLValidator extends Validator<String> {
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const URLValidator({this.message});

  @override
  FutureOr<ValidationResult?> validate(
      BuildContext context, String? value, FormValidationMode state) {
    if (value == null) {
      return null;
    }
    try {
      Uri.parse(value);
    } on FormatException {
      return InvalidResult(
          message ?? Localizations.of(context, ShadcnLocalizations).invalidURL,
          state: state);
    }
    return null;
  }

  @override
  bool operator ==(Object other) {
    return other is URLValidator && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class CompareTo<T extends Comparable<T>> extends Validator<T> {
  final T? value;
  final CompareType type;
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const CompareTo(this.value, this.type, {this.message});
  const CompareTo.equal(this.value, {this.message}) : type = CompareType.equal;
  const CompareTo.greater(this.value, {this.message})
      : type = CompareType.greater;
  const CompareTo.greaterOrEqual(this.value, {this.message})
      : type = CompareType.greaterOrEqual;
  const CompareTo.less(this.value, {this.message}) : type = CompareType.less;
  const CompareTo.lessOrEqual(this.value, {this.message})
      : type = CompareType.lessOrEqual;

  int _compare(T? a, T? b) {
    if (a == null && b == null) {
      return 0;
    }
    if (a == null) {
      return -1;
    }
    if (b == null) {
      return 1;
    }
    return a.compareTo(b);
  }

  @override
  FutureOr<ValidationResult?> validate(
      BuildContext context, T? value, FormValidationMode state) {
    var localizations = Localizations.of(context, ShadcnLocalizations);
    var compare = _compare(value, this.value);
    switch (type) {
      case CompareType.greater:
        if (compare <= 0) {
          return InvalidResult(
              message ?? localizations.formGreaterThan(this.value),
              state: state);
        }
        break;
      case CompareType.greaterOrEqual:
        if (compare < 0) {
          return InvalidResult(
              message ?? localizations.formGreaterThanOrEqualTo(this.value),
              state: state);
        }
        break;
      case CompareType.less:
        if (compare >= 0) {
          return InvalidResult(
              message ?? localizations.formLessThan(this.value),
              state: state);
        }
        break;
      case CompareType.lessOrEqual:
        if (compare > 0) {
          return InvalidResult(
              message ?? localizations.formLessThanOrEqualTo(this.value),
              state: state);
        }
        break;
      case CompareType.equal:
        if (compare != 0) {
          return InvalidResult(message ?? localizations.formEqualTo(this.value),
              state: state);
        }
        break;
    }
    return null;
  }

  @override
  bool operator ==(Object other) {
    return other is CompareTo &&
        other.value == value &&
        other.type == type &&
        other.message == message;
  }

  @override
  int get hashCode => Object.hash(value, type, message);
}

class CompositeValidator<T> extends Validator<T> {
  final List<Validator<T>> validators;

  const CompositeValidator(this.validators);

  @override
  FutureOr<ValidationResult?> validate(
      BuildContext context, T? value, FormValidationMode state) {
    return _chainValidation(context, value, state, 0);
  }

  FutureOr<ValidationResult?> _chainValidation(
      BuildContext context, T? value, FormValidationMode state, int index) {
    if (index >= validators.length) {
      return null;
    }
    var validator = validators[index];
    var result = validator.validate(context, value, state);
    if (result is Future<ValidationResult?>) {
      return result.then((nextValue) {
        if (nextValue != null) {
          return nextValue;
        }
        if (!context.mounted) {
          return null;
        }
        return _chainValidation(context, value, state, index + 1);
      });
    }
    if (result != null) {
      return result;
    }
    return _chainValidation(context, value, state, index + 1);
  }

  @override
  Validator<T> combine(Validator<T> other) {
    return CompositeValidator([...validators, other]);
  }

  @override
  bool shouldRevalidate(FormKey<dynamic> source) {
    for (var validator in validators) {
      if (validator.shouldRevalidate(source)) {
        return true;
      }
    }
    return false;
  }

  @override
  bool operator ==(Object other) {
    return other is CompositeValidator &&
        listEquals(other.validators, validators);
  }

  @override
  int get hashCode => validators.hashCode;
}

abstract class ValidationResult {
  final FormValidationMode state;
  const ValidationResult({required this.state});
}

class ReplaceResult<T> extends ValidationResult {
  final T value;

  const ReplaceResult(this.value, {required super.state});
}

class InvalidResult extends ValidationResult {
  final String message;

  const InvalidResult(this.message, {required super.state});
}

class FormValidityNotification extends Notification {
  final ValidationResult? oldValidity;
  final ValidationResult? newValidity;

  const FormValidityNotification(this.newValidity, this.oldValidity);
}

class FormKey<T> extends LocalKey {
  final Object key;

  const FormKey(this.key);

  Type get type => T;

  bool isInstanceOf(dynamic value) {
    return value is T;
  }

  @override
  bool operator ==(Object other) {
    return other is FormKey && other.key == key;
  }

  @override
  int get hashCode => key.hashCode;

  @override
  String toString() {
    return 'FormKey($key)';
  }
}

typedef AutoCompleteKey = FormKey<String>;
typedef CheckboxKey = FormKey<CheckboxState>;
typedef ChipInputKey<T> = FormKey<List<T>>;
typedef ColorPickerKey = FormKey<Color>;
typedef DatePickerKey = FormKey<DateTime>;
typedef InputOTPKey = FormKey<List<int?>>;
typedef MultiSelectKey<T> = FormKey<List<T>>;
typedef NumberInputKey = FormKey<num>;
typedef PhoneInputKey = FormKey<PhoneNumber>;
typedef RadioCardKey = FormKey<int>;
typedef RadioGroupKey = FormKey<int>;
typedef SelectKey<T> = FormKey<T>;
typedef SliderKey = FormKey<SliderValue>;
typedef StarRatingKey = FormKey<double>;
typedef SwitchKey = FormKey<bool>;
typedef TextAreaKey = FormKey<String>;
typedef TextFieldKey = FormKey<String>;
typedef TimePickerKey = FormKey<TimeOfDay>;
typedef ToggleKey = FormKey<bool>;

class FormEntry<T> extends StatefulWidget {
  final Widget child;
  final Validator<T>? validator;

  const FormEntry(
      {required FormKey<T> super.key, required this.child, this.validator});

  @override
  FormKey get key => super.key as FormKey;

  @override
  State<FormEntry> createState() => FormEntryState();
}

mixin FormFieldHandle {
  FutureOr<ValidationResult?> reportNewFormValue(Object? value);
  ValueListenable<ValidationResult?>? get validity;
}

class FormEntryState extends State<FormEntry> with FormFieldHandle {
  FormController? _controller;
  Object? _cachedValue;
  final ValueNotifier<ValidationResult?> _validity = ValueNotifier(null);

  @override
  ValueListenable<ValidationResult?>? get validity => _validity;

  int _toWaitCounter = 0;
  FutureOr<ValidationResult?>? _toWait;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var oldController = _controller;
    var newController = Data.maybeOf<FormController>(context);
    if (oldController != newController) {
      oldController?.removeListener(_onControllerChanged);
      oldController?.detach(widget.key);
      newController?.addListener(_onControllerChanged);
      _controller = newController;
      _onControllerChanged();
      if (_cachedValue != null) {
        newController?.attach(
            context, widget.key, _cachedValue, widget.validator);
      }
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_onControllerChanged);
    _controller?.detach(widget.key);
    super.dispose();
  }

  void _onControllerChanged() {
    var validityFuture = _controller?.getError(widget.key);
    if (validityFuture == _toWait) {
      return;
    }
    _toWait = validityFuture;
    int counter = ++_toWaitCounter;
    if (_toWait is Future<ValidationResult?>) {
      (_toWait as Future<ValidationResult?>).then((value) {
        if (counter == _toWaitCounter) {
          _validity.value = value;
        }
      });
    } else {
      _validity.value = _toWait as ValidationResult?;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Data<FormFieldHandle>.inherit(
      data: this,
      child: widget.child,
    );
  }

  @override
  FutureOr<ValidationResult?> reportNewFormValue(Object? value) {
    if (!widget.key.isInstanceOf(value)) {
      return null;
    }
    if (_cachedValue == value) {
      return null;
    }
    _cachedValue = value;
    return _controller?.attach(context, widget.key, value, widget.validator);
  }
}

class FormEntryInterceptor<T> extends StatefulWidget {
  final Widget child;
  final ValueChanged<T>? onValueReported;

  const FormEntryInterceptor(
      {super.key, required this.child, this.onValueReported});

  @override
  State<FormEntryInterceptor<T>> createState() =>
      _FormEntryInterceptorState<T>();
}

class _FormEntryInterceptorState<T> extends State<FormEntryInterceptor<T>> {
  FormFieldHandle? _handle;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _handle = Data.maybeOf<FormFieldHandle>(context);
  }

  void _onValueReported(Object? value) {
    var callback = widget.onValueReported;
    if (callback != null && value is T) {
      callback(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Data<FormFieldHandle>.inherit(
      data: _FormEntryHandleInterceptor(_handle, _onValueReported),
      child: widget.child,
    );
  }
}

class _FormEntryHandleInterceptor with FormFieldHandle {
  final FormFieldHandle? handle;
  final void Function(Object? value) onValueReported;

  const _FormEntryHandleInterceptor(this.handle, this.onValueReported);

  @override
  FutureOr<ValidationResult?> reportNewFormValue(Object? value) {
    return handle?.reportNewFormValue(value);
  }

  @override
  ValueListenable<ValidationResult?>? get validity => handle?.validity;

  @override
  String toString() {
    return '_FormEntryHandleInterceptor($handle, $onValueReported)';
  }

  @override
  bool operator ==(Object other) {
    return other is _FormEntryHandleInterceptor &&
        other.handle == handle &&
        other.onValueReported == onValueReported;
  }

  @override
  int get hashCode => Object.hash(handle, onValueReported);
}

class FormValueState<T> {
  final T? value;
  final Validator<T>? validator;

  FormValueState({this.value, this.validator});

  @override
  String toString() {
    return 'FormValueState($value, $validator)';
  }

  @override
  bool operator ==(Object other) {
    return other is FormValueState &&
        other.value == value &&
        other.validator == validator;
  }

  @override
  int get hashCode => Object.hash(value, validator);
}

typedef FormSubmitCallback = void Function(
    BuildContext context, Map<FormKey, dynamic> values);

class Form extends StatefulWidget {
  final FormController? controller;
  final Widget child;
  final FormSubmitCallback? onSubmit;
  const Form({super.key, required this.child, this.onSubmit, this.controller});

  @override
  State<Form> createState() => FormState();
}

class FormController extends ChangeNotifier {
  final Map<FormKey, FormValueState> _attachedInputs = {};
  final Map<FormKey, FutureOr<ValidationResult?>> _validity = {};

  bool _disposed = false;

  Map<FormKey, dynamic> get values {
    return {
      for (var entry in _attachedInputs.entries) entry.key: entry.value.value
    };
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  Map<FormKey, FutureOr<ValidationResult?>> get validities {
    return Map.unmodifiable(_validity);
  }

  FutureOr<ValidationResult?>? getError(FormKey key) {
    return _validity[key];
  }

  FormValueState? getState(FormKey key) {
    return _attachedInputs[key];
  }

  void revalidate(BuildContext context, FormValidationMode state) {
    bool changed = false;
    for (var entry in _attachedInputs.entries) {
      var key = entry.key;
      var value = entry.value;
      if (value.validator != null) {
        var future = value.validator!.validate(context, value.value, state);
        if (_validity[key] != future) {
          _validity[key] = future;
          if (future is Future<ValidationResult?>) {
            future.then((value) {
              if (_validity[key] == future) {
                _validity[key] = value;
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  if (_disposed) {
                    return;
                  }
                  notifyListeners();
                });
              }
            });
          }
          changed = true;
        }
      }
    }
    if (changed) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (_disposed) {
          return;
        }
        notifyListeners();
      });
    }
  }

  FutureOr<ValidationResult?> attach(
      BuildContext context, FormKey key, Object? value, Validator? validator) {
    final oldState = _attachedInputs[key];
    var state = FormValueState(value: value, validator: validator);
    if (oldState == state) {
      return null;
    }
    var lifecycle = oldState == null
        ? FormValidationMode.initial
        : FormValidationMode.changed;
    _attachedInputs[key] = state;
    // validate
    var future = validator?.validate(context, value, lifecycle);
    _validity[key] = future;
    if (future is Future<ValidationResult?>) {
      future.then((value) {
        // resolve the future and store synchronous value
        if (_validity[key] == future) {
          _validity[key] = value;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            if (_disposed) {
              return;
            }
            notifyListeners();
          });
        }
      });
    }
    // check for revalidation
    Map<FormKey, FutureOr<ValidationResult?>> revalidate = {};
    for (var entry in _attachedInputs.entries) {
      var k = entry.key;
      var value = entry.value;
      if (key == k) {
        continue;
      }
      if (value.validator != null && value.validator!.shouldRevalidate(key)) {
        var revalidateResult =
            value.validator!.validate(context, value.value, lifecycle);
        revalidate[k] = revalidateResult;
      }
    }
    for (var entry in revalidate.entries) {
      var k = entry.key;
      var future = entry.value;
      var attachedInput = _attachedInputs[k]!;
      attachedInput = FormValueState(
          value: attachedInput.value, validator: attachedInput.validator);
      _attachedInputs[k] = attachedInput;
      _validity[k] = future;
      if (future is Future<ValidationResult?>) {
        future.then((value) {
          if (_validity[k] == future) {
            _validity[k] = value;
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              if (_disposed) {
                return;
              }
              notifyListeners();
            });
          }
        });
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_disposed) {
        return;
      }
      notifyListeners();
    });
    return null;
  }

  void detach(FormKey key) {
    if (_attachedInputs.containsKey(key)) {
      _attachedInputs.remove(key);
      _validity.remove(key);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (_disposed) {
          return;
        }
        notifyListeners();
      });
    }
  }
}

class FormState extends State<Form> {
  late FormController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? FormController();
  }

  @override
  void didUpdateWidget(covariant Form oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _controller = widget.controller ?? FormController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Data.inherit(
      data: this,
      child: Data.inherit(
        data: _controller,
        child: widget.child,
      ),
    );
  }
}

class FormEntryErrorBuilder extends StatelessWidget {
  final Widget Function(
      BuildContext context, ValidationResult? error, Widget? child) builder;
  final Widget? child;
  final Set<FormValidationMode>? modes;

  const FormEntryErrorBuilder(
      {super.key, required this.builder, this.child, this.modes});

  @override
  Widget build(BuildContext context) {
    final formController = Data.maybeOf<FormFieldHandle>(context);
    if (formController != null) {
      var validityListenable = formController.validity;
      return ListenableBuilder(
          listenable: Listenable.merge([
            if (validityListenable != null) validityListenable,
          ]),
          builder: (context, child) {
            var validity = validityListenable?.value;
            if (modes != null && !modes!.contains(validity?.state)) {
              return builder(context, null, child);
            }
            return builder(context, validity, child);
          },
          child: child);
    }
    return builder(context, null, child);
  }
}

class WaitingResult extends ValidationResult {
  const WaitingResult({required super.state});
}

class FormErrorBuilder extends StatelessWidget {
  final Widget? child;
  final Widget Function(BuildContext context,
      Map<FormKey, ValidationResult> errors, Widget? child) builder;

  const FormErrorBuilder({super.key, required this.builder, this.child});

  @override
  Widget build(BuildContext context) {
    final formController = Data.maybeOf<FormController>(context);
    if (formController != null) {
      return AnimatedBuilder(
        animation: formController,
        child: child,
        builder: (context, child) {
          final errors = formController.validities;
          // future builder
          return FutureBuilder<List<MapEntry<FormKey, ValidationResult?>>>(
            future: Future.wait(errors.entries.map((entry) {
              var key = entry.key;
              var value = entry.value;
              if (value is Future<ValidationResult?>) {
                return value.then((value) => MapEntry(key, value));
              }
              return Future.value(MapEntry(key, value));
            })),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return builder(
                    context,
                    {
                      for (var entry in formController._attachedInputs.entries)
                        entry.key: const WaitingResult(
                            state: FormValidationMode.waiting)
                    },
                    child);
              }
              if (snapshot.hasData) {
                final errors = <FormKey, ValidationResult>{};
                for (var entry in snapshot.data!) {
                  var key = entry.key;
                  var value = entry.value;
                  if (value != null) {
                    errors[key] = value;
                  }
                }
                return builder(context, errors, child);
              }
              return builder(context, {}, child);
            },
          );
        },
      );
    }
    return builder(context, {}, child);
  }
}

extension FormExtension on BuildContext {
  T? getFormValue<T>(FormKey<T> key) {
    final formController = Data.maybeOf<FormController>(this);
    if (formController != null) {
      final state = formController.getState(key);
      if (state != null) {
        return state.value;
      }
    }
    return null;
  }

  FutureOr<SubmissionResult> submitForm() {
    final formState = Data.maybeOf<FormState>(this);
    assert(formState != null, 'Form not found');
    final formController = Data.maybeOf<FormController>(this);
    assert(formController != null, 'Form not found');
    final values = <FormKey, Object?>{};
    for (var entry in formController!._attachedInputs.entries) {
      var key = entry.key;
      var value = entry.value;
      values[key] = value.value;
    }
    formController.revalidate(this, FormValidationMode.submitted);
    var errors = <FormKey, ValidationResult>{};
    var iterator = formController._validity.entries.iterator;
    var result = _chainedSubmitForm(values, errors, iterator);
    if (result is Future<SubmissionResult>) {
      return result.then((value) {
        if (value.errors.isNotEmpty) {
          return value;
        }
        formState?.widget.onSubmit?.call(this, values);
        return value;
      });
    }
    if (result.errors.isNotEmpty) {
      return result;
    }
    formState?.widget.onSubmit?.call(this, values);
    return result;
  }

  FutureOr<SubmissionResult> _chainedSubmitForm(
      Map<FormKey, Object?> values,
      Map<FormKey, ValidationResult> errors,
      Iterator<MapEntry<FormKey, FutureOr<ValidationResult?>>> iterator) {
    if (!iterator.moveNext()) {
      return SubmissionResult(values, errors);
    }
    var entry = iterator.current;
    var value = entry.value;
    if (value is Future<ValidationResult?>) {
      return value.then((value) {
        if (value != null) {
          errors[entry.key] = value;
        }
        return _chainedSubmitForm(values, errors, iterator);
      });
    }
    return _chainedSubmitForm(values, errors, iterator);
  }
}

mixin FormValueSupplier<T, X extends StatefulWidget> on State<X> {
  T? _cachedValue;
  int _futureCounter = 0;
  FormFieldHandle? _entryState;

  T? get formValue => _cachedValue;
  set formValue(T? value) {
    if (_cachedValue == value) {
      return;
    }
    _cachedValue = value;
    _reportNewFormValue(value);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var newState = Data.maybeOf<FormFieldHandle>(context);
    if (newState != _entryState) {
      _entryState = newState;
      _reportNewFormValue(_cachedValue);
    }
  }

  @protected
  void didReplaceFormValue(T value);

  void _reportNewFormValue(T? value) {
    var state = _entryState;
    if (state == null) {
      return;
    }
    final currentCounter = ++_futureCounter;
    var validationResult = state.reportNewFormValue(value);
    if (validationResult is Future<ValidationResult?>) {
      validationResult.then((value) {
        if (_futureCounter == currentCounter) {
          if (value is ReplaceResult<T>) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              if (context.mounted) {
                didReplaceFormValue(value.value);
              }
            });
          }
        }
      });
    } else if (validationResult is ReplaceResult<T>) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (context.mounted) {
          didReplaceFormValue(validationResult.value);
        }
      });
    }
  }
}

class SubmissionResult {
  final Map<FormKey, Object?> values;
  final Map<FormKey, ValidationResult> errors;

  const SubmissionResult(this.values, this.errors);

  @override
  String toString() {
    return 'SubmissionResult($values, $errors)';
  }

  @override
  bool operator ==(Object other) {
    return other is SubmissionResult &&
        mapEquals(other.values, values) &&
        mapEquals(other.errors, errors);
  }
}

class FormField<T> extends StatelessWidget {
  final Widget label;
  final Widget? hint;
  final Widget child;
  final Widget? leadingLabel;
  final Widget? trailingLabel;
  final MainAxisAlignment? labelAxisAlignment;
  final double? leadingGap;
  final double? trailingGap;
  final EdgeInsetsGeometry? padding;
  final Validator<T>? validator;
  final Set<FormValidationMode>? showErrors;

  const FormField({
    required FormKey<T> super.key,
    required this.label,
    required this.child,
    this.leadingLabel,
    this.trailingLabel,
    this.labelAxisAlignment = MainAxisAlignment.start,
    this.leadingGap,
    this.trailingGap,
    this.padding = EdgeInsets.zero,
    this.validator,
    this.hint,
    this.showErrors,
  });

  @override
  FormKey<T> get key => super.key as FormKey<T>;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FormEntry<T>(
      key: key,
      validator: validator,
      child: FormEntryErrorBuilder(
        modes: showErrors,
        builder: (context, error, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: padding!,
                child: Row(
                  mainAxisAlignment: labelAxisAlignment!,
                  children: [
                    if (leadingLabel != null) leadingLabel!.textSmall().muted(),
                    if (leadingLabel != null)
                      Gap(leadingGap ?? theme.scaling * 8),
                    Expanded(
                      child: DefaultTextStyle.merge(
                        style: error != null
                            ? TextStyle(color: theme.colorScheme.destructive)
                            : null,
                        child: label.textSmall(),
                      ),
                    ),
                    if (trailingLabel != null)
                      Gap(trailingGap ?? theme.scaling * 8),
                    if (trailingLabel != null)
                      trailingLabel!.textSmall().muted(),
                  ],
                ),
              ),
              Gap(theme.scaling * 8),
              child!,
              if (hint != null) ...[
                Gap(theme.scaling * 8),
                hint!.xSmall().muted(),
              ],
              if (error is InvalidResult) ...[
                Gap(theme.scaling * 8),
                DefaultTextStyle.merge(
                  style: TextStyle(color: theme.colorScheme.destructive),
                  child: Text(error.message).xSmall().medium(),
                ),
              ],
            ],
          );
        },
        child: child,
      ),
    );
  }
}

class FormInline<T> extends StatelessWidget {
  final Widget label;
  final Widget? hint;
  final Widget child;
  final Validator<T>? validator;
  final Set<FormValidationMode>? showErrors;

  const FormInline({
    required FormKey<T> super.key,
    required this.label,
    required this.child,
    this.validator,
    this.hint,
    this.showErrors,
  });

  @override
  FormKey<T> get key => super.key as FormKey<T>;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FormEntry<T>(
      key: key,
      validator: validator,
      child: FormEntryErrorBuilder(
        modes: showErrors,
        builder: (context, error, child) {
          return IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DefaultTextStyle.merge(
                        style: error != null
                            ? TextStyle(color: theme.colorScheme.destructive)
                            : null,
                        child: label.textSmall(),
                      ),
                      Gap(theme.scaling * 8),
                      Expanded(child: child!),
                    ],
                  ),
                ),
                if (hint != null) ...[
                  const Gap(8),
                  hint!.xSmall().muted(),
                ],
                if (error is InvalidResult) ...[
                  const Gap(8),
                  DefaultTextStyle.merge(
                    style: TextStyle(color: theme.colorScheme.destructive),
                    child: Text(error.message).xSmall().medium(),
                  ),
                ],
              ],
            ),
          );
        },
        child: child,
      ),
    );
  }
}

class FormTableLayout extends StatelessWidget {
  final List<FormField> rows;
  final double? spacing;

  const FormTableLayout({super.key, required this.rows, this.spacing});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    var spacing = this.spacing ?? scaling * 16;
    return DefaultTextStyle.merge(
      style: TextStyle(color: Theme.of(context).colorScheme.foreground),
      child: widgets.Table(
        columnWidths: const {
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(),
        },
        children: [
          for (int i = 0; i < rows.length; i++)
            widgets.TableRow(
              children: [
                rows[i]
                    .label
                    .textSmall()
                    .withAlign(AlignmentDirectional.centerEnd)
                    .withMargin(right: 16 * scaling)
                    .sized(height: 32 * scaling)
                    .withPadding(
                      top: i == 0 ? 0 : spacing,
                      left: 16 * scaling,
                    ),
                FormEntry(
                  key: rows[i].key,
                  validator: rows[i].validator,
                  child: FormEntryErrorBuilder(
                    modes: rows[i].showErrors,
                    builder: (context, error, child) {
                      return IntrinsicWidth(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            child!,
                            if (rows[i].hint != null) ...[
                              Gap(8 * scaling),
                              rows[i].hint!.xSmall().muted(),
                            ],
                            if (error is InvalidResult) ...[
                              Gap(8 * scaling),
                              DefaultTextStyle.merge(
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .destructive),
                                child: Text(error.message).xSmall().medium(),
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                    child: rows[i].child,
                  ),
                ).withPadding(
                  top: i == 0 ? 0 : spacing,
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class SubmitButton extends StatefulWidget {
  final AbstractButtonStyle? style;
  final Widget child;
  final Widget? loading;
  final Widget? error;
  final Widget? leading;
  final Widget? trailing;
  final Widget? loadingLeading;
  final Widget? loadingTrailing;
  final Widget? errorLeading;
  final Widget? errorTrailing;
  final AlignmentGeometry? alignment;
  final bool disableHoverEffect;
  final bool? enabled;
  final bool? enableFeedback;
  final bool disableTransition;
  final FocusNode? focusNode;

  const SubmitButton({
    super.key,
    required this.child,
    this.style,
    this.loading,
    this.error,
    this.leading,
    this.trailing,
    this.alignment,
    this.loadingLeading,
    this.loadingTrailing,
    this.errorLeading,
    this.errorTrailing,
    this.disableHoverEffect = false,
    this.enabled,
    this.enableFeedback,
    this.disableTransition = false,
    this.focusNode,
  });

  @override
  widgets.State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends widgets.State<SubmitButton> {
  FutureOr<bool>? _future;
  FormController? _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var oldController = _controller;
    var newController = Data.maybeOf<FormController>(context);
    if (oldController != newController) {
      oldController?.removeListener(_onControllerChanged);
      newController?.addListener(_onControllerChanged);
      _controller = newController;
      if (_controller != null) {
        _onControllerChanged();
      }
    }
  }

  void _onControllerChanged() {
    if (!mounted) {
      return;
    }
    setState(() {
      _future = _hasError();
    });
  }

  int count = 0;

  FutureOr<bool> _hasError() {
    if (_controller == null) {
      return false;
    }
    return _chainedHasError(_controller!._validity.entries.iterator);
  }

  FutureOr<bool> _chainedHasError(
      Iterator<MapEntry<FormKey, FutureOr<ValidationResult?>>> iterator) {
    if (!iterator.moveNext()) {
      return false;
    }
    var entry = iterator.current;
    var value = entry.value;
    if (value is Future<ValidationResult?>) {
      return value.then((value) {
        if (value != null) {
          return true;
        }
        return _chainedHasError(iterator);
      });
    }
    if (value != null) {
      return true;
    }
    return _chainedHasError(iterator);
  }

  @override
  Widget build(widgets.BuildContext context) {
    var hasError = _future;
    if (hasError is Future) {
      // loading
      return Button(
        leading: widget.loadingLeading ?? widget.leading,
        trailing: widget.loadingTrailing ?? widget.trailing,
        alignment: widget.alignment,
        disableHoverEffect: widget.disableHoverEffect,
        enabled: false,
        enableFeedback: false,
        disableTransition: widget.disableTransition,
        focusNode: widget.focusNode,
        style: widget.style ?? const ButtonStyle.primary(),
        child: widget.loading ?? widget.child,
      );
    }
    if (hasError == true) {
      return Button(
        leading: widget.errorLeading ?? widget.leading,
        trailing: widget.errorTrailing ?? widget.trailing,
        alignment: widget.alignment,
        disableHoverEffect: widget.disableHoverEffect,
        enabled: false,
        enableFeedback: true,
        disableTransition: widget.disableTransition,
        focusNode: widget.focusNode,
        style: widget.style ?? const ButtonStyle.primary(),
        child: widget.error ?? widget.child,
      );
    }
    return Button(
      trailing: widget.trailing,
      leading: widget.leading,
      alignment: widget.alignment,
      disableHoverEffect: widget.disableHoverEffect,
      enabled: widget.enabled,
      enableFeedback: widget.enableFeedback,
      onPressed: () {
        setState(() {
          var submissionResult = context.submitForm();
          if (submissionResult is Future<SubmissionResult>) {
            _future = submissionResult.then((value) {
              return value.errors.isNotEmpty;
            });
          } else {
            _future = submissionResult.errors.isNotEmpty;
          }
        });
      },
      disableTransition: widget.disableTransition,
      focusNode: widget.focusNode,
      style: widget.style ?? const ButtonStyle.primary(),
      child: widget.child,
    );
  }
}
