import 'dart:async';

import 'package:email_validator/email_validator.dart' as email_validator;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' as widgets;

import '../../../shadcn_flutter.dart';

/// Abstract base class for implementing form field validation logic.
///
/// Validators are responsible for checking the validity of form field values
/// and returning appropriate validation results. They support both synchronous
/// and asynchronous validation through the [FutureOr] return type.
///
/// Validators can be combined using logical operators:
/// - `&` or `+`: Combines validators (all must pass)
/// - `|`: Creates OR logic (at least one must pass)
/// - `~` or unary `-`: Negates the validator result
///
/// The generic type [T] represents the type of value being validated.
///
/// Example:
/// ```dart
/// final validator = RequiredValidator<String>() &
///                   MinLengthValidator(3) &
///                   EmailValidator();
/// ```
abstract class Validator<T> {
  /// Creates a [Validator].
  const Validator();

  /// Validates the given [value] and returns a validation result.
  ///
  /// This method performs the actual validation logic and should return
  /// null if the value is valid, or a [ValidationResult] describing the
  /// validation error if invalid.
  ///
  /// Parameters:
  /// - [context] (BuildContext): The build context for localization access
  /// - [value] (T?): The value to validate (may be null)
  /// - [lifecycle] (FormValidationMode): The current validation trigger mode
  ///
  /// Returns a [FutureOr<ValidationResult?>] that is null for valid values
  /// or contains error information for invalid values.
  FutureOr<ValidationResult?> validate(
      BuildContext context, T? value, FormValidationMode lifecycle);

  /// Combines this validator with another validator using AND logic.
  ///
  /// Both validators must pass for the combined validator to be valid.
  /// If either validator fails, the combined validator fails.
  ///
  /// Parameters:
  /// - [other] (Validator<T>): The validator to combine with this one
  ///
  /// Returns a new [CompositeValidator] that requires both validators to pass.
  ///
  /// Example:
  /// ```dart
  /// final combined = requiredValidator.combine(emailValidator);
  /// ```
  Validator<T> combine(Validator<T> other) {
    return CompositeValidator([this, other]);
  }

  /// Combines this validator with another using AND logic (alias for [combine]).
  ///
  /// This operator provides a convenient syntax for combining validators
  /// where both must pass for validation to succeed.
  ///
  /// Example:
  /// ```dart
  /// final validator = RequiredValidator<String>() & EmailValidator();
  /// ```
  Validator<T> operator &(Validator<T> other) {
    return combine(other);
  }

  /// Combines this validator with another using OR logic.
  ///
  /// At least one validator must pass for the combined validator to be valid.
  /// Only if both validators fail will the combined validator fail.
  ///
  /// Parameters:
  /// - [other] (Validator<T>): The validator to combine with this one using OR logic
  ///
  /// Returns a new [OrValidator] that requires at least one validator to pass.
  ///
  /// Example:
  /// ```dart
  /// final validator = emailValidator | phoneValidator;
  /// ```
  Validator<T> operator |(Validator<T> other) {
    return OrValidator([this, other]);
  }

  /// Negates this validator's result.
  ///
  /// Creates a validator that passes when this validator fails, and
  /// fails when this validator passes. Useful for creating inverse
  /// validation logic.
  ///
  /// Returns a [NotValidator] that inverts this validator's result.
  ///
  /// Example:
  /// ```dart
  /// final notEmpty = ~EmptyValidator<String>();
  /// ```
  Validator<T> operator ~() {
    return NotValidator(this);
  }

  /// Negates this validator's result (alias for `~` operator).
  ///
  /// Provides an alternative syntax for creating negated validators.
  ///
  /// Example:
  /// ```dart
  /// final notEmpty = -EmptyValidator<String>();
  /// ```
  Validator<T> operator -() {
    return NotValidator(this);
  }

  /// Combines this validator with another using AND logic (alias for [combine]).
  ///
  /// Alternative syntax for combining validators where both must pass.
  ///
  /// Example:
  /// ```dart
  /// final validator = requiredValidator + lengthValidator;
  /// ```
  Validator<T> operator +(Validator<T> other) {
    return combine(other);
  }

  /// Determines if this validator should be re-run when the specified form key changes.
  ///
  /// This method is used for cross-field validation where one field's validity
  /// depends on another field's value. Return true if this validator should
  /// be re-executed when the specified form field changes.
  ///
  /// Parameters:
  /// - [source] (FormKey): The form key that changed
  ///
  /// Returns true if validation should be re-run, false otherwise.
  ///
  /// Example:
  /// ```dart
  /// @override
  /// bool shouldRevalidate(FormKey source) {
  ///   return source == passwordFieldKey; // Re-validate when password changes
  /// }
  /// ```
  bool shouldRevalidate(FormKey<dynamic> source) => false;
}

/// Defines when form field validation should occur during the component lifecycle.
///
/// This enumeration controls the timing of validation execution, allowing
/// fine-grained control over when validation logic runs. Different validation
/// modes can be used to optimize user experience and performance.
enum FormValidationMode {
  /// Validation occurs when the field is first created or initialized.
  ///
  /// This mode runs validation immediately when a form field is created,
  /// which can be useful for fields with default values that need immediate
  /// validation feedback.
  initial,

  /// Validation occurs when the field value changes.
  ///
  /// This is the most common validation mode, providing immediate feedback
  /// as users interact with form fields. Validation runs after each value
  /// change event.
  changed,

  /// Validation occurs when the form is submitted.
  ///
  /// This mode defers validation until form submission, reducing interruptions
  /// during user input. Useful for complex validations that should only run
  /// when the user attempts to submit the form.
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
  FutureOr<ValidationResult?> validate(
      BuildContext context, T? value, FormValidationMode lifecycle) {
    if (mode.contains(lifecycle)) {
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

/// A function type that evaluates a condition on a value and returns a boolean result.
///
/// This type alias represents a predicate function that can be either synchronous
/// or asynchronous, accepting a nullable value of type [T] and returning either
/// a boolean or a [Future<bool>]. Used primarily for conditional validation logic.
///
/// The generic type [T] represents the type of value being evaluated.
///
/// Example:
/// ```dart
/// FuturePredicate<String> isValidEmail = (value) async {
///   if (value == null) return false;
///   return await validateEmailOnServer(value);
/// };
/// ```
typedef FuturePredicate<T> = FutureOr<bool> Function(T? value);

/// A widget that prevents form components from submitting their values to form controllers.
///
/// This widget creates a boundary that blocks form-related data propagation,
/// effectively isolating child components from parent form controllers. When
/// [ignoring] is true, any form components within the child widget tree will
/// not participate in form validation or data collection.
///
/// This is useful for creating UI components that look like form fields but
/// should not be included in form submission or validation, such as search
/// fields, filters, or decorative input elements.
///
/// Example:
/// ```dart
/// Form(
///   child: Column(
///     children: [
///       TextInput(label: 'Name'), // Participates in form
///       IgnoreForm(
///         child: TextInput(label: 'Search'), // Ignored by form
///       ),
///     ],
///   ),
/// );
/// ```
class IgnoreForm<T> extends StatelessWidget {
  /// Whether to ignore form participation for child components.
  ///
  /// When true, creates a boundary that prevents child form components
  /// from registering with parent form controllers. When false, child
  /// components behave normally and participate in form operations.
  final bool ignoring;

  /// The widget subtree to optionally isolate from form participation.
  final Widget child;

  /// Creates an [IgnoreForm] widget.
  ///
  /// Parameters:
  /// - [child] (Widget, required): The widget subtree to wrap
  /// - [ignoring] (bool, default: true): Whether to block form participation
  ///
  /// Example:
  /// ```dart
  /// IgnoreForm(
  ///   ignoring: shouldIgnore,
  ///   child: MyFormField(),
  /// );
  /// ```
  const IgnoreForm({super.key, this.ignoring = true, required this.child});

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
      if (min != null) {
        return InvalidResult(
            message ??
                Localizations.of(context, ShadcnLocalizations)
                    .formLengthLessThan(min!),
            state: state);
      }
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

  @override
  int get hashCode => Object.hash(min, max, inclusive, message);
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
  FormKey get key;
  ValidationResult attach(FormKey key);
}

class ReplaceResult<T> extends ValidationResult {
  final T value;
  final FormKey? _key;

  const ReplaceResult(this.value, {required super.state}) : _key = null;

  const ReplaceResult.attached(this.value,
      {required FormKey key, required super.state})
      : _key = key;

  @override
  FormKey get key {
    assert(_key != null, 'The result has not been attached to a key');
    return _key!;
  }

  @override
  ReplaceResult<T> attach(FormKey key) {
    return ReplaceResult.attached(value, key: key, state: state);
  }
}

class InvalidResult extends ValidationResult {
  final String message;
  final FormKey? _key;

  const InvalidResult(this.message, {required super.state}) : _key = null;
  const InvalidResult.attached(this.message,
      {required FormKey key, required super.state})
      : _key = key;

  @override
  FormKey get key {
    assert(_key != null, 'The result has not been attached to a key');
    return _key!;
  }

  @override
  InvalidResult attach(FormKey key) {
    return InvalidResult.attached(message, key: key, state: state);
  }
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

  T? getValue(FormMapValues values) {
    return values.getValue(this);
  }

  T? operator [](FormMapValues values) {
    return values.getValue(this);
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
typedef DateInputKey = FormKey<DateTime>;
typedef DurationPickerKey = FormKey<Duration>;
typedef DurationInputKey = FormKey<Duration>;
typedef InputKey = FormKey<String>;
typedef InputOTPKey = FormKey<List<int?>>;
typedef MultiSelectKey<T> = FormKey<Iterable<T>>;
typedef MultipleAnswerKey<T> = FormKey<Iterable<T>>;
typedef MultipleChoiceKey<T> = FormKey<T>;
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
typedef TimeInputKey = FormKey<TimeOfDay>;
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
  bool get mounted;
  FormKey get formKey;
  FutureOr<ValidationResult?> reportNewFormValue<T>(T? value);
  FutureOr<ValidationResult?> revalidate();
  ValueListenable<ValidationResult?>? get validity;
}

class _FormEntryCachedValue {
  Object? value;

  _FormEntryCachedValue(this.value);
}

class FormEntryState extends State<FormEntry> with FormFieldHandle {
  FormController? _controller;
  _FormEntryCachedValue? _cachedValue;
  final ValueNotifier<ValidationResult?> _validity = ValueNotifier(null);

  @override
  FormKey get formKey => widget.key;

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
      // oldController?.detach(this);
      _controller = newController;
      _onControllerChanged();
      newController?.addListener(_onControllerChanged);
      if (_cachedValue != null) {
        newController?.attach(
            context, this, _cachedValue?.value, widget.validator);
      }
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_onControllerChanged);
    // _controller?.detach(this);
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
  FutureOr<ValidationResult?> reportNewFormValue<T>(T? value) {
    bool isSameType = widget.key.type == T;
    if (!isSameType) {
      var parentLookup = Data.maybeFind<FormFieldHandle>(context);
      assert(parentLookup != this, 'FormEntry cannot be its own parent');
      return parentLookup?.reportNewFormValue<T>(value);
    }
    var cachedValue = _cachedValue;
    if (cachedValue != null && cachedValue.value == value) {
      return _validity.value;
    }
    _cachedValue = _FormEntryCachedValue(value);
    return _controller?.attach(context, this, value, widget.validator);
  }

  @override
  FutureOr<ValidationResult?> revalidate() {
    return _controller?.attach(
        context, this, _cachedValue, widget.validator, true);
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
  FormKey get formKey => handle!.formKey;

  @override
  bool get mounted => handle!.mounted;

  @override
  FutureOr<ValidationResult?> reportNewFormValue<T>(T? value) {
    onValueReported(value);
    return handle?.reportNewFormValue<T>(value);
  }

  @override
  FutureOr<ValidationResult?> revalidate() {
    return handle?.revalidate();
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

typedef FormMapValues = Map<FormKey, dynamic>;

typedef FormSubmitCallback = void Function(
    BuildContext context, FormMapValues values);

extension FormMapValuesExtension on FormMapValues {
  T? getValue<T>(FormKey<T> key) {
    Object? value = this[key];
    if (value == null) {
      return null;
    }
    assert(key.isInstanceOf(value),
        'The value for key $key is not of type ${key.type}');
    return value as T?;
  }
}

/// A widget that provides form management capabilities for collecting and validating user input.
///
/// The Form widget creates a container that manages multiple form fields, providing
/// centralized validation, data collection, and submission handling. It maintains
/// form state through a [FormController] and coordinates validation across all
/// participating form fields.
///
/// Form components within the widget tree automatically register themselves with
/// the nearest Form ancestor, allowing centralized management of field values,
/// validation states, and error handling. The Form provides validation lifecycle
/// management and supports both synchronous and asynchronous validation.
///
/// Example:
/// ```dart
/// final controller = FormController();
///
/// Form(
///   controller: controller,
///   onSubmit: (values) async {
///     print('Form submitted with values: $values');
///   },
///   child: Column(
///     children: [
///       TextInput(
///         key: FormKey<String>('name'),
///         label: 'Name',
///         validator: RequiredValidator(),
///       ),
///       Button(
///         onPressed: () => controller.submit(),
///         child: Text('Submit'),
///       ),
///     ],
///   ),
/// );
/// ```
class Form extends StatefulWidget {
  /// Retrieves the nearest [FormController] from the widget tree, if any.
  ///
  /// Returns the [FormController] instance from the nearest Form ancestor,
  /// or null if no Form is found in the widget tree. This method is safe
  /// to call even when no Form is present.
  ///
  /// Parameters:
  /// - [context] (BuildContext): The build context to search from
  ///
  /// Returns the [FormController] if found, null otherwise.
  static FormController? maybeOf(BuildContext context) {
    return Data.maybeOf<FormController>(context);
  }

  /// Retrieves the nearest [FormController] from the widget tree.
  ///
  /// Returns the [FormController] instance from the nearest Form ancestor.
  /// Throws an assertion error if no Form is found in the widget tree.
  /// Use [maybeOf] if the Form might not be present.
  ///
  /// Parameters:
  /// - [context] (BuildContext): The build context to search from
  ///
  /// Returns the [FormController] from the nearest Form ancestor.
  ///
  /// Throws [AssertionError] if no Form is found in the widget tree.
  static FormController of(BuildContext context) {
    return Data.of<FormController>(context);
  }

  /// Optional controller for programmatic form management.
  ///
  /// When provided, this controller manages form state externally and allows
  /// programmatic access to form values, validation states, and submission.
  /// If null, the Form creates and manages its own internal controller.
  final FormController? controller;

  /// The widget subtree containing form fields.
  ///
  /// This child widget should contain the form fields and other UI elements
  /// that participate in the form. Form fields within this subtree automatically
  /// register with this Form instance.
  final Widget child;

  /// Callback invoked when the form is submitted.
  ///
  /// This callback receives a map of form values keyed by their [FormKey]
  /// identifiers. It is called when [FormController.submit] is invoked and
  /// all form validations pass successfully.
  ///
  /// The callback can return a Future for asynchronous submission processing.
  final FormSubmitCallback? onSubmit;

  /// Creates a [Form] widget.
  ///
  /// The [child] parameter is required and should contain the form fields
  /// and UI elements that participate in the form. The [controller] and
  /// [onSubmit] parameters are optional but commonly used for form management.
  ///
  /// Parameters:
  /// - [child] (Widget, required): The widget subtree containing form fields
  /// - [onSubmit] (FormSubmitCallback?, optional): Callback for form submission
  /// - [controller] (FormController?, optional): External form state controller
  ///
  /// Example:
  /// ```dart
  /// Form(
  ///   onSubmit: (values) => print('Submitted: $values'),
  ///   child: Column(
  ///     children: [
  ///       TextInput(key: FormKey('email'), label: 'Email'),
  ///       Button(child: Text('Submit')),
  ///     ],
  ///   ),
  /// );
  /// ```
  const Form({super.key, required this.child, this.onSubmit, this.controller});

  @override
  State<Form> createState() => FormState();
}

class _ValidatorResultStash {
  final FutureOr<ValidationResult?> result;
  final FormValidationMode state;

  const _ValidatorResultStash(this.result, this.state);
}

/// Controller for managing form state, validation, and submission.
///
/// The FormController coordinates all form field interactions, maintaining
/// a centralized registry of field values and validation states. It provides
/// programmatic access to form data collection, validation triggering, and
/// submission handling.
///
/// The controller automatically manages the lifecycle of form fields as they
/// register and unregister, tracking their values and validation results.
/// It supports both synchronous and asynchronous validation, cross-field
/// validation dependencies, and comprehensive error state management.
///
/// Example:
/// ```dart
/// final controller = FormController();
///
/// // Listen to form state changes
/// controller.addListener(() {
///   print('Form validity: ${controller.isValid}');
///   print('Form values: ${controller.values}');
/// });
///
/// // Submit the form
/// await controller.submit();
///
/// // Access specific field values
/// final emailValue = controller.getValue(emailKey);
/// ```
class FormController extends ChangeNotifier {
  final Map<FormKey, FormValueState> _attachedInputs = {};
  final Map<FormKey, _ValidatorResultStash> _validity = {};

  bool _disposed = false;

  /// A map of all current form field values keyed by their [FormKey].
  ///
  /// This getter provides access to the current state of all registered form
  /// fields. The map is rebuilt on each access to reflect the latest values
  /// from all active form fields.
  ///
  /// Returns a Map<FormKey, Object?> where each key corresponds to a form field
  /// and each value is the current value of that field.
  Map<FormKey, Object?> get values {
    return {
      for (var entry in _attachedInputs.entries) entry.key: entry.value.value
    };
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  /// A map of all current validation results keyed by their [FormKey].
  ///
  /// This getter provides access to the validation state of all registered
  /// form fields. Values can be either synchronous ValidationResult objects
  /// or Future<ValidationResult?> for asynchronous validation.
  ///
  /// Returns a Map<FormKey, FutureOr<ValidationResult?>> representing the
  /// current validation state of all form fields.
  Map<FormKey, FutureOr<ValidationResult?>> get validities {
    return {for (var entry in _validity.entries) entry.key: entry.value.result};
  }

  /// A map of all current validation errors keyed by their [FormKey].
  ///
  /// This getter filters the validation results to only include fields with
  /// validation errors. For asynchronous validations that are still pending,
  /// a [WaitingResult] is included to indicate the validation is in progress.
  ///
  /// Returns a Map<FormKey, ValidationResult> containing only fields with errors.
  Map<FormKey, ValidationResult> get errors {
    final errors = <FormKey, ValidationResult>{};
    for (var entry in _validity.entries) {
      var result = entry.value.result;
      if (result is Future<ValidationResult?>) {
        errors[entry.key] =
            WaitingResult.attached(state: entry.value.state, key: entry.key);
      } else if (result != null) {
        errors[entry.key] = result;
      }
    }
    return errors;
  }

  /// Retrieves the validation result for a specific form field.
  ///
  /// This method returns the current validation state for the specified form key,
  /// which can be either a synchronous ValidationResult or a Future for asynchronous
  /// validation. Returns null if no validation result exists for the key.
  ///
  /// Parameters:
  /// - [key] (FormKey): The form key to get validation result for
  ///
  /// Returns the validation result or null if none exists.
  FutureOr<ValidationResult?>? getError(FormKey key) {
    return _validity[key]?.result;
  }

  /// Retrieves the synchronous validation result for a specific form field.
  ///
  /// This method returns the current validation state for the specified form key,
  /// converting asynchronous validations to [WaitingResult] objects. This provides
  /// a synchronous interface for accessing validation states.
  ///
  /// Parameters:
  /// - [key] (FormKey): The form key to get validation result for
  ///
  /// Returns the synchronous validation result or null if valid.
  ValidationResult? getSyncError(FormKey key) {
    var entry = _validity[key];
    var result = entry?.result;
    if (result is Future<ValidationResult?>) {
      return WaitingResult.attached(state: entry!.state, key: key);
    }
    return result;
  }

  T? getValue<T>(FormKey<T> key) {
    return _attachedInputs[key]?.value as T?;
  }

  bool hasValue(FormKey key) {
    return _attachedInputs[key]?.value != null;
  }

  void revalidate(BuildContext context, FormValidationMode state) {
    bool changed = false;
    for (var entry in _attachedInputs.entries) {
      var key = entry.key;
      var value = entry.value;
      if (value.validator != null) {
        var future = value.validator!.validate(context, value.value, state);
        if (_validity[key]?.result != future) {
          if (future is Future<ValidationResult?>) {
            _validity[key] = _ValidatorResultStash(future, state);
            future.then((value) {
              if (_validity[key]?.result == future) {
                _validity[key] =
                    _ValidatorResultStash(value?.attach(key), state);
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  if (_disposed) {
                    return;
                  }
                  notifyListeners();
                });
              }
            });
          } else {
            _validity[key] = _ValidatorResultStash(future, state);
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

  FutureOr<ValidationResult?> attach(BuildContext context,
      FormFieldHandle handle, Object? value, Validator? validator,
      [bool forceRevalidate = false]) {
    final key = handle.formKey;
    final oldState = _attachedInputs[key];
    var state = FormValueState(value: value, validator: validator);
    if (oldState == state && !forceRevalidate) {
      return _validity[key]?.result;
    }
    var lifecycle = oldState == null
        ? FormValidationMode.initial
        : FormValidationMode.changed;
    _attachedInputs[key] = state;
    // validate
    var future = validator?.validate(context, value, lifecycle);
    if (future is Future<ValidationResult?>) {
      _validity[key] = _ValidatorResultStash(future, lifecycle);
      future.then((value) {
        // resolve the future and store synchronous value
        if (_validity[key]?.result == future) {
          _validity[key] = _ValidatorResultStash(value?.attach(key), lifecycle);
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            if (_disposed) {
              return;
            }
            notifyListeners();
          });
        }
      });
    } else {
      _validity[key] = _ValidatorResultStash(future, lifecycle);
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
      if (future is Future<ValidationResult?>) {
        _validity[k] = _ValidatorResultStash(future, lifecycle);
        future.then((value) {
          if (_validity[k]?.result == future) {
            _validity[k] = _ValidatorResultStash(value?.attach(k), lifecycle);
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              if (_disposed) {
                return;
              }
              notifyListeners();
            });
          }
        });
      } else {
        _validity[k] = _ValidatorResultStash(future, lifecycle);
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_disposed) {
        return;
      }
      notifyListeners();
    });
    return _validity[key]?.result;
  }

  // void detach(FormFieldHandle key) {
  //   if (_attachedInputs.containsKey(key)) {
  //     final oldValue = _attachedInputs.remove(key);
  //     _validity.remove(key);
  //     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //       if (_disposed) {
  //         return;
  //       }
  //       notifyListeners();
  //     });
  //   }
  // }
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
  final FormKey? _key;
  const WaitingResult.attached({required FormKey key, required super.state})
      : _key = key;

  @override
  FormKey get key {
    assert(_key != null, 'The result has not been attached to a key');
    return _key!;
  }

  @override
  WaitingResult attach(FormKey key) {
    return WaitingResult.attached(key: key, state: state);
  }
}

class FormErrorBuilder extends StatelessWidget {
  final Widget? child;
  final Widget Function(BuildContext context,
      Map<FormKey, ValidationResult> errors, Widget? child) builder;

  const FormErrorBuilder({super.key, required this.builder, this.child});

  @override
  Widget build(BuildContext context) {
    final formController = Data.of<FormController>(context);
    return ListenableBuilder(
      listenable: formController,
      child: child,
      builder: (context, child) {
        return builder(context, formController.errors, child);
      },
    );
  }
}

typedef FormPendingWidgetBuilder = Widget Function(BuildContext context,
    Map<FormKey, Future<ValidationResult?>> errors, Widget? child);

class FormPendingBuilder extends StatelessWidget {
  final Widget? child;
  final FormPendingWidgetBuilder builder;

  const FormPendingBuilder({super.key, required this.builder, this.child});

  @override
  Widget build(widgets.BuildContext context) {
    final controller = Data.maybeOf<FormController>(context);
    if (controller != null) {
      return AnimatedBuilder(
        animation: controller,
        child: child,
        builder: (context, child) {
          final errors = controller.validities;
          final pending = <FormKey, Future<ValidationResult?>>{};
          for (var entry in errors.entries) {
            var key = entry.key;
            var value = entry.value;
            if (value is Future<ValidationResult?>) {
              pending[key] = value;
            }
          }
          return builder(context, pending, child);
        },
      );
    }
    return builder(context, {}, child);
  }
}

extension FormExtension on BuildContext {
  T? getFormValue<T>(FormKey<T> key) {
    final formController = Data.maybeFind<FormController>(this);
    if (formController != null) {
      final state = formController.getValue(key);
      return state;
    }
    return null;
  }

  FutureOr<SubmissionResult> submitForm() {
    final formState = Data.maybeFind<FormState>(this);
    assert(formState != null, 'Form not found');
    final formController = Data.maybeFind<FormController>(this);
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
      Iterator<MapEntry<FormKey, _ValidatorResultStash>> iterator) {
    if (!iterator.moveNext()) {
      return SubmissionResult(values, errors);
    }
    var entry = iterator.current;
    var value = entry.value.result;
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
  _FormEntryCachedValue? _cachedValue;
  int _futureCounter = 0;
  FormFieldHandle? _entryState;

  T? get formValue => _cachedValue?.value as T?;
  set formValue(T? value) {
    if (_cachedValue != null && _cachedValue!.value == value) {
      return;
    }
    _cachedValue = _FormEntryCachedValue(value);
    _reportNewFormValue(value);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var newState = Data.maybeOf<FormFieldHandle>(context);
    if (newState != _entryState) {
      _entryState = newState;
      _reportNewFormValue(_cachedValue?.value as T?);
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
    var validationResult = state.reportNewFormValue<T>(value);
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

  @override
  int get hashCode => Object.hash(
      Object.hashAll(values.entries), Object.hashAll(errors.entries));
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
          return ComponentTheme(
            data: FocusOutlineTheme(
              border: error != null
                  ? Border.all(
                      color: theme.colorScheme.destructive.scaleAlpha(0.2),
                      width: 3.0)
                  : null,
            ),
            child: ComponentTheme(
              data: TextFieldTheme(
                border: error != null
                    ? Border.all(color: theme.colorScheme.destructive)
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: padding!,
                    child: Row(
                      mainAxisAlignment: labelAxisAlignment!,
                      children: [
                        if (leadingLabel != null)
                          leadingLabel!.textSmall().muted(),
                        if (leadingLabel != null)
                          Gap(leadingGap ?? theme.scaling * 8),
                        Expanded(
                          child: DefaultTextStyle.merge(
                            style: error != null
                                ? TextStyle(
                                    color: theme.colorScheme.destructive)
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
              ),
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
                      return ComponentTheme(
                        data: FocusOutlineTheme(
                          border: error != null
                              ? Border.all(
                                  color: theme.colorScheme.destructive
                                      .scaleAlpha(0.2),
                                  width: 3.0)
                              : null,
                        ),
                        child: ComponentTheme(
                          data: TextFieldTheme(
                            border: error != null
                                ? Border.all(
                                    color: theme.colorScheme.destructive)
                                : null,
                          ),
                          child: IntrinsicWidth(
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
                                    child:
                                        Text(error.message).xSmall().medium(),
                                  ),
                                ],
                              ],
                            ),
                          ),
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

class SubmitButton extends StatelessWidget {
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
  widgets.Widget build(widgets.BuildContext context) {
    return FormErrorBuilder(
      builder: (context, errors, child) {
        var hasWaitingError = errors.values.any((element) {
          return element is WaitingResult;
        });
        var hasError = errors.values.any((element) {
          return element is InvalidResult;
        });
        if (hasWaitingError) {
          return Button(
            leading: loadingLeading ?? leading,
            trailing: loadingTrailing ?? trailing,
            alignment: alignment,
            disableHoverEffect: disableHoverEffect,
            enabled: false,
            enableFeedback: false,
            disableTransition: disableTransition,
            focusNode: focusNode,
            style: style ?? const ButtonStyle.primary(),
            child: loading ?? child!,
          );
        }
        if (hasError) {
          return Button(
            leading: errorLeading ?? leading,
            trailing: errorTrailing ?? trailing,
            alignment: alignment,
            disableHoverEffect: disableHoverEffect,
            enabled: false,
            enableFeedback: true,
            disableTransition: disableTransition,
            focusNode: focusNode,
            style: style ?? const ButtonStyle.primary(),
            child: error ?? child!,
          );
        }
        return Button(
          leading: leading,
          trailing: trailing,
          alignment: alignment,
          disableHoverEffect: disableHoverEffect,
          enabled: enabled ?? true,
          enableFeedback: enableFeedback ?? true,
          onPressed: () {
            context.submitForm();
          },
          disableTransition: disableTransition,
          focusNode: focusNode,
          style: style ?? const ButtonStyle.primary(),
          child: child!,
        );
      },
      child: child,
    );
  }
}
