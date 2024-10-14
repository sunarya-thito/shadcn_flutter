import 'package:email_validator/email_validator.dart' as email_validator;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' as widgets;

import '../../../shadcn_flutter.dart';

abstract class Validator<T> {
  const Validator();
  Future<ValidationResult?> validate(
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

  Validator<T> operator +(Validator<T> other) {
    return combine(other);
  }

  bool shouldRevalidate(FormKey<dynamic> source) => false;
}

enum FormValidationMode {
  initial,
  changed,
  submitted,
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
  Future<ValidationResult?> validate(
      BuildContext context, T? value, FormValidationMode lifecycle) async {
    if (this.mode.contains(lifecycle)) {
      return await validator.validate(context, value, lifecycle);
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

typedef FuturePredicate<T> = Future<bool> Function(T? value);

class ConditionalValidator<T> extends Validator<T> {
  final FuturePredicate<T> predicate;
  final String message;

  const ConditionalValidator(this.predicate, {required this.message});

  @override
  Future<ValidationResult?> validate(
      BuildContext context, T? value, FormValidationMode state) async {
    if (!await predicate(value)) {
      return InvalidResult(message);
    }
    return null;
  }

  @override
  bool shouldRevalidate(FormKey<dynamic> source) {
    return true;
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

class NotValidator<T> extends Validator<T> {
  final Validator<T> validator;
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const NotValidator(this.validator, {this.message});

  @override
  Future<ValidationResult?> validate(
      BuildContext context, T? value, FormValidationMode state) async {
    var localizations = Localizations.of(context, ShadcnLocalizations);
    var result = await validator.validate(context, value, state);
    if (result == null) {
      return InvalidResult(message ?? localizations.invalidValue);
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
  Future<ValidationResult?> validate(
      BuildContext context, T? value, FormValidationMode state) async {
    ValidationResult? result;
    for (var validator in validators) {
      result = await validator.validate(context, value, state);
      if (result == null) {
        return null;
      }
    }
    return result;
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
  Future<ValidationResult?> validate(
      BuildContext context, T? value, FormValidationMode state) async {
    if (value == null) {
      var localizations = Localizations.of(context, ShadcnLocalizations);
      return InvalidResult(message ?? localizations.formNotEmpty);
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
  Future<ValidationResult?> validate(
      BuildContext context, String? value, FormValidationMode state) async {
    if (value == null || value.isEmpty) {
      var localizations = Localizations.of(context, ShadcnLocalizations);
      return InvalidResult(message ?? localizations.formNotEmpty);
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
  Future<ValidationResult?> validate(
      BuildContext context, String? value, FormValidationMode state) async {
    if (value == null) {
      return null;
    }
    ShadcnLocalizations localizations =
        Localizations.of(context, ShadcnLocalizations);
    if (min != null && value.length < min!) {
      return InvalidResult(message ?? localizations.formLengthLessThan(min!));
    }
    if (max != null && value.length > max!) {
      return InvalidResult(
          message ?? localizations.formLengthGreaterThan(max!));
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
  Future<ValidationResult?> validate(
      BuildContext context, T? value, FormValidationMode state) async {
    var localizations = Localizations.of(context, ShadcnLocalizations);
    var otherValue = context.getFormValue(key);
    if (otherValue == null) {
      return InvalidResult(message ?? localizations.invalidValue);
    }
    var compare = _compare(value, otherValue);
    switch (type) {
      case CompareType.greater:
        if (compare <= 0) {
          return InvalidResult(
              message ?? localizations.formGreaterThan(otherValue));
        }
        break;
      case CompareType.greaterOrEqual:
        if (compare < 0) {
          return InvalidResult(
              message ?? localizations.formGreaterThanOrEqualTo(otherValue));
        }
        break;
      case CompareType.less:
        if (compare >= 0) {
          return InvalidResult(
              message ?? localizations.formLessThan(otherValue));
        }
        break;
      case CompareType.lessOrEqual:
        if (compare > 0) {
          return InvalidResult(
              message ?? localizations.formLessThanOrEqualTo(otherValue));
        }
        break;
      case CompareType.equal:
        if (compare != 0) {
          return InvalidResult(
              message ?? localizations.formEqualTo(otherValue));
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
  Future<ValidationResult?> validate(
      BuildContext context, String? value, FormValidationMode state) async {
    if (value == null) {
      return null;
    }
    if (requireDigit && !RegExp(r'\d').hasMatch(value)) {
      return InvalidResult(message ??
          Localizations.of(context, ShadcnLocalizations).formPasswordDigits);
    }
    if (requireLowercase && !RegExp(r'[a-z]').hasMatch(value)) {
      return InvalidResult(message ??
          Localizations.of(context, ShadcnLocalizations).formPasswordLowercase);
    }
    if (requireUppercase && !RegExp(r'[A-Z]').hasMatch(value)) {
      return InvalidResult(message ??
          Localizations.of(context, ShadcnLocalizations).formPasswordUppercase);
    }
    if (requireSpecialChar && !RegExp(r'[\W_]').hasMatch(value)) {
      return InvalidResult(message ??
          Localizations.of(context, ShadcnLocalizations).formPasswordSpecial);
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
  Future<ValidationResult?> validate(
      BuildContext context, T? value, FormValidationMode state) async {
    if (value == null) {
      return null;
    }
    if (inclusive) {
      if (value < min) {
        return InvalidResult(message ??
            Localizations.of(context, ShadcnLocalizations)
                .formGreaterThanOrEqualTo(min));
      }
    } else {
      if (value <= min) {
        return InvalidResult(message ??
            Localizations.of(context, ShadcnLocalizations)
                .formGreaterThan(min));
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
  Future<ValidationResult?> validate(
      BuildContext context, T? value, FormValidationMode state) async {
    if (value == null) {
      return null;
    }
    if (inclusive) {
      if (value > max) {
        return InvalidResult(message ??
            Localizations.of(context, ShadcnLocalizations)
                .formLessThanOrEqualTo(max));
      }
    } else {
      if (value >= max) {
        return InvalidResult(message ??
            Localizations.of(context, ShadcnLocalizations).formLessThan(max));
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
  Future<ValidationResult?> validate(
      BuildContext context, T? value, FormValidationMode state) async {
    if (value == null) {
      return null;
    }
    if (inclusive) {
      if (value < min || value > max) {
        return InvalidResult(message ??
            Localizations.of(context, ShadcnLocalizations)
                .formBetweenInclusively(min, max));
      }
    } else {
      if (value <= min || value >= max) {
        return InvalidResult(message ??
            Localizations.of(context, ShadcnLocalizations)
                .formBetweenExclusively(min, max));
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
  Future<ValidationResult?> validate(
      BuildContext context, String? value, FormValidationMode state) async {
    if (value == null) {
      return null;
    }
    if (!pattern.hasMatch(value)) {
      return InvalidResult(message ??
          Localizations.of(context, ShadcnLocalizations).invalidValue);
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
  Future<ValidationResult?> validate(
      BuildContext context, String? value, FormValidationMode state) async {
    if (value == null) {
      return null;
    }
    if (!email_validator.EmailValidator.validate(value)) {
      return InvalidResult(message ??
          Localizations.of(context, ShadcnLocalizations).invalidEmail);
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
  Future<ValidationResult?> validate(
      BuildContext context, String? value, FormValidationMode state) async {
    if (value == null) {
      return null;
    }
    try {
      Uri.parse(value);
    } on FormatException {
      return InvalidResult(
          message ?? Localizations.of(context, ShadcnLocalizations).invalidURL);
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
  Future<ValidationResult?> validate(
      BuildContext context, T? value, FormValidationMode state) async {
    var localizations = Localizations.of(context, ShadcnLocalizations);
    var compare = _compare(value, this.value);
    switch (type) {
      case CompareType.greater:
        if (compare <= 0) {
          return InvalidResult(
              message ?? localizations.formGreaterThan(this.value));
        }
        break;
      case CompareType.greaterOrEqual:
        if (compare < 0) {
          return InvalidResult(
              message ?? localizations.formGreaterThanOrEqualTo(this.value));
        }
        break;
      case CompareType.less:
        if (compare >= 0) {
          return InvalidResult(
              message ?? localizations.formLessThan(this.value));
        }
        break;
      case CompareType.lessOrEqual:
        if (compare > 0) {
          return InvalidResult(
              message ?? localizations.formLessThanOrEqualTo(this.value));
        }
        break;
      case CompareType.equal:
        if (compare != 0) {
          return InvalidResult(
              message ?? localizations.formEqualTo(this.value));
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
  Future<ValidationResult?> validate(
      BuildContext context, T? value, FormValidationMode state) async {
    for (var validator in validators) {
      var result = await validator.validate(context, value, state);
      if (result != null) {
        return result;
      }
    }
    return null;
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
  const ValidationResult();
}

class ReplaceResult<T> extends ValidationResult {
  final T value;

  const ReplaceResult(this.value);
}

class InvalidResult extends ValidationResult {
  final String message;

  const InvalidResult(this.message);
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

class FormEntry<T> extends StatefulWidget {
  final Widget child;
  final Validator<T>? validator;

  const FormEntry(
      {required FormKey super.key, required this.child, this.validator});

  @override
  FormKey get key => super.key as FormKey;

  @override
  State<FormEntry> createState() => FormEntryState();
}

class FormEntryState extends State<FormEntry> {
  FormController? _controller;
  Object? _cachedValue;
  final ValueNotifier<ValidationResult?> _validity = ValueNotifier(null);

  ValueListenable<ValidationResult?> get validity => _validity;

  int _toWaitCounter = 0;
  Future<ValidationResult?>? _toWait;

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
    _toWait?.then((value) {
      if (counter == _toWaitCounter) {
        _validity.value = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Data.inherit(
      data: this,
      child: widget.child,
    );
  }
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
  final Map<FormKey, Future<ValidationResult?>> _validity = {};

  Map<FormKey, dynamic> get values {
    return {
      for (var entry in _attachedInputs.entries) entry.key: entry.value.value
    };
  }

  Map<FormKey, Future<ValidationResult?>> get validities {
    return Map.unmodifiable(_validity);
  }

  Future<ValidationResult?>? getError(FormKey key) {
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
          changed = true;
        }
      }
    }
    if (changed) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        notifyListeners();
      });
    }
  }

  Future<ValidationResult?>? attach(
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
    if (future != null) {
      _validity[key] = future;
    }
    // check for revalidation
    Map<FormKey, Future<ValidationResult?>> revalidate = {};
    for (var entry in _attachedInputs.entries) {
      var k = entry.key;
      var value = entry.value;
      if (key == k) {
        continue;
      }
      if (value.validator != null && value.validator!.shouldRevalidate(key)) {
        revalidate[k] =
            value.validator!.validate(context, value.value, lifecycle);
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
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
    return future;
  }

  void detach(FormKey key) {
    if (_attachedInputs.containsKey(key)) {
      _attachedInputs.remove(key);
      _validity.remove(key);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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

  const FormEntryErrorBuilder({super.key, required this.builder, this.child});

  @override
  Widget build(BuildContext context) {
    final formController = Data.maybeOf<FormEntryState>(context);
    if (formController != null) {
      return ValueListenableBuilder<ValidationResult?>(
        valueListenable: formController._validity,
        child: child,
        builder: (context, validity, child) {
          return builder(context, validity, child);
        },
      );
    }
    return builder(context, null, child);
  }
}

class WaitingResult extends ValidationResult {
  const WaitingResult();
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
        builder: (context, child) {
          final errors = formController.validities;
          // future builder
          return FutureBuilder<List<MapEntry<FormKey, ValidationResult?>>>(
            future: Future.wait(errors.entries.map((entry) async {
              var key = entry.key;
              var value = await entry.value;
              return MapEntry(key, value);
            })),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return builder(
                    context,
                    {
                      for (var entry in formController._attachedInputs.entries)
                        entry.key: const WaitingResult()
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

  Future<SubmissionResult> submitForm() async {
    final formState = Data.maybeOf<FormState>(this);
    assert(formState != null, 'Form not found');
    final formController = Data.maybeOf<FormController>(this);
    assert(formController != null, 'Form not found');
    final values = <FormKey, dynamic>{};
    final errors = <FormKey, ValidationResult>{};
    for (var entry in formController!._attachedInputs.entries) {
      var key = entry.key;
      var value = entry.value;
      values[key] = value.value;
    }
    formController.revalidate(this, FormValidationMode.submitted);
    for (var entry in formController._validity.entries) {
      var key = entry.key;
      var value = await entry.value;
      if (value != null) {
        errors[key] = value;
      }
    }
    if (errors.isNotEmpty) {
      return SubmissionResult(values, errors);
    }
    formState?.widget.onSubmit?.call(this, values);
    return SubmissionResult(values, errors);
  }

  Future<ValidationResult?>? reportNewFormValue<T>(T value) async {
    final formController = Data.maybeOf<FormController>(this);
    if (formController != null) {
      final formEntry = Data.maybeOf<FormEntryState>(this);
      if (formEntry != null) {
        var formKey = formEntry.widget.key;
        if (formKey.isInstanceOf(value) && formEntry._cachedValue != value) {
          formEntry._cachedValue = value;
          final oldState = formController.getState(formKey);
          if (oldState != null) {
            if (oldState.value == value) {
              return null;
            }
          }
          return formController.attach(
              this, formKey, value, formEntry.widget.validator);
        }
      }
    }
    return null;
  }
}

mixin FormValueSupplier<X extends StatefulWidget> on State<X> {
  int _futureCounter = 0;
  Future<bool> reportNewFormValue<T>(T value, ValueChanged<T> onReplace) {
    final currentCounter = ++_futureCounter;
    return context.reportNewFormValue(value)?.then((value) {
          if (_futureCounter == currentCounter) {
            if (value is ReplaceResult<T>) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                if (context.mounted) {
                  onReplace(value.value);
                }
              });
              return false;
            }
          }
          return true;
        }) ??
        Future.value(true);
  }
}

class SubmissionResult {
  final Map<FormKey, dynamic> values;
  final Map<FormKey, ValidationResult> errors;

  const SubmissionResult(this.values, this.errors);
}

class FormField<T> extends StatelessWidget {
  final Widget label;
  final Widget? hint;
  final Widget child;
  final Validator<T>? validator;

  const FormField({
    required FormKey<T> super.key,
    required this.label,
    required this.child,
    this.validator,
    this.hint,
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
        builder: (context, error, child) {
          return IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                mergeAnimatedTextStyle(
                  style: error != null
                      ? TextStyle(color: theme.colorScheme.destructive)
                      : null,
                  child: label.textSmall(),
                  duration: kDefaultDuration,
                ),
                Gap(theme.scaling * 8),
                child!,
                if (hint != null) ...[
                  Gap(theme.scaling * 8),
                  hint!.xSmall().muted(),
                ],
                if (error is InvalidResult) ...[
                  Gap(theme.scaling * 8),
                  mergeAnimatedTextStyle(
                    style: TextStyle(color: theme.colorScheme.destructive),
                    child: Text(error.message).xSmall().medium(),
                    duration: kDefaultDuration,
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

class FormInline<T> extends StatelessWidget {
  final Widget label;
  final Widget? hint;
  final Widget child;
  final Validator<T>? validator;

  const FormInline({
    required FormKey<T> super.key,
    required this.label,
    required this.child,
    this.validator,
    this.hint,
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
        builder: (context, error, child) {
          return IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      mergeAnimatedTextStyle(
                        style: error != null
                            ? TextStyle(color: theme.colorScheme.destructive)
                            : null,
                        child: label.textSmall(),
                        duration: kDefaultDuration,
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
                  mergeAnimatedTextStyle(
                    style: TextStyle(color: theme.colorScheme.destructive),
                    child: Text(error.message).xSmall().medium(),
                    duration: kDefaultDuration,
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
    return mergeAnimatedTextStyle(
      duration: kDefaultDuration,
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
                              mergeAnimatedTextStyle(
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .destructive),
                                child: Text(error.message).xSmall().medium(),
                                duration: kDefaultDuration,
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
  final bool trailingExpanded;
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
    this.trailingExpanded = false,
    this.disableTransition = false,
    this.focusNode,
  });

  @override
  widgets.State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends widgets.State<SubmitButton> {
  Future<bool>? _future;
  FormController? _controller;
  bool _isSubmitting = false;

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

  Future<bool> _hasError() async {
    if (_controller == null) {
      return false;
    }
    for (var entry in _controller!._validity.entries) {
      var value = await entry.value;
      if (value != null) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(widgets.BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Button(
            leading: _isSubmitting ? widget.loadingLeading ?? widget.leading : widget.leading,
            trailing: _isSubmitting ? widget.loadingTrailing ?? widget.trailing : widget.trailing,
            alignment: widget.alignment,
            disableHoverEffect: widget.disableHoverEffect,
            enabled: false,
            enableFeedback: false,
            trailingExpanded: widget.trailingExpanded,
            disableTransition: widget.disableTransition,
            focusNode: widget.focusNode,
            style: widget.style ?? const ButtonStyle.primary(),
            child: _isSubmitting ? widget.loading ?? widget.child : widget.child,
          );
        }
        if (snapshot.hasData && snapshot.requireData) {
          return Button(
            leading: widget.errorLeading ?? widget.leading,
            trailing: widget.errorTrailing ?? widget.trailing,
            alignment: widget.alignment,
            disableHoverEffect: widget.disableHoverEffect,
            enabled: false,
            enableFeedback: true,
            trailingExpanded: widget.trailingExpanded,
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
              _isSubmitting = true;
              _future = context.submitForm().then((value) {
                _isSubmitting = false;
                return value.errors.isNotEmpty;
              });
            });
          },
          trailingExpanded: widget.trailingExpanded,
          disableTransition: widget.disableTransition,
          focusNode: widget.focusNode,
          style: widget.style ?? const ButtonStyle.primary(),
          child: widget.child,
        );
      },
    );
  }
}
