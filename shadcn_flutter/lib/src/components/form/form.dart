import 'package:email_validator/email_validator.dart' as email_validator;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' as widgets;

import '../../../shadcn_flutter.dart';

abstract class Validator<T> {
  const Validator();
  Future<ValidationResult?> validate(BuildContext context, T? value);

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

class NotValidator<T> extends Validator<T> {
  final Validator<T> validator;
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const NotValidator(this.validator, {this.message});

  @override
  Future<ValidationResult?> validate(BuildContext context, T? value) async {
    var localizations = Localizations.of(context, ShadcnLocalizations);
    var result = await validator.validate(context, value);
    if (result == null) {
      return InvalidResult(message ?? localizations.invalidValue);
    }
    return null;
  }
}

class OrValidator<T> extends Validator<T> {
  final List<Validator<T>> validators;

  const OrValidator(this.validators);

  @override
  Future<ValidationResult?> validate(BuildContext context, T? value) async {
    ValidationResult? result;
    for (var validator in validators) {
      result = await validator.validate(context, value);
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
}

class NonNullValidator<T> extends Validator<T> {
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const NonNullValidator({this.message});

  @override
  Future<ValidationResult?> validate(BuildContext context, T? value) async {
    if (value == null) {
      var localizations = Localizations.of(context, ShadcnLocalizations);
      return InvalidResult(message ?? localizations.formNotEmpty);
    }
    return null;
  }
}

class NotEmptyValidator extends NonNullValidator<String> {
  const NotEmptyValidator({String? message}) : super(message: message);

  @override
  Future<ValidationResult?> validate(
      BuildContext context, String? value) async {
    if (value == null || value.isEmpty) {
      var localizations = Localizations.of(context, ShadcnLocalizations);
      return InvalidResult(message ?? localizations.formNotEmpty);
    }
    return null;
  }
}

class LengthValidator extends Validator<String> {
  final int? min;
  final int? max;
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const LengthValidator({this.min, this.max, this.message});

  @override
  Future<ValidationResult?> validate(
      BuildContext context, String? value) async {
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
  Future<ValidationResult?> validate(BuildContext context, T? value) async {
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
      BuildContext context, String? value) async {
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
}

class MinValidator<T extends num> extends Validator<T> {
  final T min;
  final bool inclusive;
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const MinValidator(this.min, {this.inclusive = true, this.message});

  @override
  Future<ValidationResult?> validate(BuildContext context, T? value) async {
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
}

class MaxValidator<T extends num> extends Validator<T> {
  final T max;
  final bool inclusive;
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const MaxValidator(this.max, {this.inclusive = true, this.message});

  @override
  Future<ValidationResult?> validate(BuildContext context, T? value) async {
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
  Future<ValidationResult?> validate(BuildContext context, T? value) async {
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
}

class RegexValidator extends Validator<String> {
  final RegExp pattern;
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const RegexValidator(this.pattern, {this.message});

  @override
  Future<ValidationResult?> validate(
      BuildContext context, String? value) async {
    if (value == null) {
      return null;
    }
    if (!pattern.hasMatch(value)) {
      return InvalidResult(message ??
          Localizations.of(context, ShadcnLocalizations).invalidValue);
    }
    return null;
  }
}

// email validator using email_validator package
class EmailValidator extends Validator<String> {
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const EmailValidator({this.message});

  @override
  Future<ValidationResult?> validate(
      BuildContext context, String? value) async {
    if (value == null) {
      return null;
    }
    if (!email_validator.EmailValidator.validate(value)) {
      return InvalidResult(message ??
          Localizations.of(context, ShadcnLocalizations).invalidEmail);
    }
    return null;
  }
}

class URLValidator extends Validator<String> {
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const URLValidator({this.message});

  @override
  Future<ValidationResult?> validate(
      BuildContext context, String? value) async {
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
  Future<ValidationResult?> validate(BuildContext context, T? value) async {
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
}

class CompositeValidator<T> extends Validator<T> {
  final List<Validator<T>> validators;

  const CompositeValidator(this.validators);

  @override
  Future<ValidationResult?> validate(BuildContext context, T? value) async {
    for (var validator in validators) {
      var result = await validator.validate(context, value);
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

mixin FormValueInput<T> on State<StatefulWidget> {}

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
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_onControllerChanged);
    _controller?.detach(widget.key);
    super.dispose();
  }

  void _onControllerChanged() {
    var validityFuture = _controller?.getState(widget.key)?.validity;
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
    return Data(
      data: this,
      child: widget.child,
    );
  }
}

class FormValueState<T> {
  final T? value;
  final Future<ValidationResult?>? validity;
  final Validator<T>? validator;

  FormValueState({this.value, this.validity, this.validator});

  @override
  String toString() {
    return 'FormValueState($value, $validity, $validator)';
  }
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

  Map<FormKey, dynamic> get values {
    return {
      for (var entry in _attachedInputs.entries) entry.key: entry.value.value
    };
  }

  Map<FormKey, Future<ValidationResult?>> get errors {
    return {
      for (var entry in _attachedInputs.entries)
        if (entry.value.validity != null) entry.key: entry.value.validity!
    };
  }

  FormValueState? getState(FormKey key) {
    return _attachedInputs[key];
  }

  void attach(BuildContext context, FormKey key, FormValueState state) {
    final oldState = _attachedInputs[key];
    if (oldState == state) {
      return;
    }
    _attachedInputs[key] = state;
    // check for revalidation
    Map<FormKey, Future<ValidationResult?>> revalidate = {};
    for (var entry in _attachedInputs.entries) {
      var k = entry.key;
      var value = entry.value;
      if (key == k) {
        continue;
      }
      if (value.validator != null && value.validator!.shouldRevalidate(key)) {
        revalidate[k] = value.validator!.validate(context, value.value);
      }
    }
    for (var entry in revalidate.entries) {
      var k = entry.key;
      var future = entry.value;
      var attachedInput = _attachedInputs[k]!;
      attachedInput = FormValueState(
          value: attachedInput.value,
          validity: future,
          validator: attachedInput.validator);
      _attachedInputs[k] = attachedInput;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }

  void detach(FormKey key) {
    if (_attachedInputs.containsKey(key)) {
      _attachedInputs.remove(key);
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
    return Data(
      data: this,
      child: Data(
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
          final errors = <FormKey, Future<ValidationResult?>>{};
          for (var entry in formController._attachedInputs.entries) {
            var key = entry.key;
            var value = entry.value;
            if (value.validity != null) {
              errors[key] = value.validity!;
            }
          }
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
      if (value.validity != null) {
        var result = await value.validity!;
        if (result != null) {
          errors[key] = result;
        }
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
        Type type = formKey.type;
        if (type == value.runtimeType) {
          final oldState = formController.getState(formKey);
          if (oldState != null) {
            if (oldState.value == value) {
              return null;
            }
            final oldFuture = oldState.validity;
            if (oldFuture != null) {
              return oldFuture.then((oldValidity) async {
                var validity =
                    formEntry.widget.validator?.validate(this, value);
                formController.attach(
                    this,
                    formKey,
                    FormValueState(
                        value: value,
                        validity: validity,
                        validator: formEntry.widget.validator));
                return validity;
              });
            }
          }
          var validity = formEntry.widget.validator?.validate(this, value);
          formController.attach(
              this,
              formKey,
              FormValueState(
                  value: value,
                  validity: validity,
                  validator: formEntry.widget.validator));
          return validity;
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

class FormRow<T> extends StatelessWidget {
  final Widget label;
  final Widget? hint;
  final Widget child;
  final Validator<T>? validator;

  const FormRow({
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
                  Gap(8),
                  hint!.xSmall().muted(),
                ],
                if (error is InvalidResult) ...[
                  Gap(8),
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
  final List<FormRow> rows;
  final double spacing;

  const FormTableLayout({super.key, required this.rows, this.spacing = 16});

  @override
  Widget build(BuildContext context) {
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
                    .withAlign(Alignment.centerRight)
                    .withMargin(right: 16)
                    .sized(height: 32)
                    .withPadding(
                      top: i == 0 ? 0 : spacing,
                      left: 16,
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
                              Gap(8),
                              rows[i].hint!.xSmall().muted(),
                            ],
                            if (error is InvalidResult) ...[
                              Gap(8),
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
