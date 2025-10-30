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
  /// Returns a `FutureOr<ValidationResult?>` that is null for valid values
  /// or contains error information for invalid values.
  FutureOr<ValidationResult?> validate(
      BuildContext context, T? value, FormValidationMode lifecycle);

  /// Combines this validator with another validator using AND logic.
  ///
  /// Both validators must pass for the combined validator to be valid.
  /// If either validator fails, the combined validator fails.
  ///
  /// Parameters:
  /// - [other] (`Validator<T>`): The validator to combine with this one
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
  /// - [other] (`Validator<T>`): The validator to combine with this one using OR logic
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

/// A validator wrapper that controls when validation occurs based on form lifecycle.
///
/// [ValidationMode] wraps another validator and only executes it during specific
/// validation modes. This allows fine-grained control over when validation rules
/// are applied during the form lifecycle (initial load, value changes, submission).
///
/// Example:
/// ```dart
/// ValidationMode(
///   EmailValidator(),
///   mode: {FormValidationMode.changed, FormValidationMode.submitted},
/// )
/// ```
class ValidationMode<T> extends Validator<T> {
  /// The underlying validator to execute when mode conditions are met.
  final Validator<T> validator;

  /// The set of validation modes during which this validator should run.
  final Set<FormValidationMode> mode;

  /// Creates a [ValidationMode] that conditionally validates based on lifecycle mode.
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
/// a boolean or a `Future<bool>`. Used primarily for conditional validation logic.
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

/// A validator that applies conditional validation based on form state.
///
/// [ConditionalValidator] only executes validation when a predicate condition
/// is met. This allows validation rules to depend on other form field values
/// or dynamic conditions.
///
/// Example:
/// ```dart
/// ConditionalValidator<String>(
///   (context, value, getFieldValue) async {
///     final country = await getFieldValue('country');
///     return country == 'US';
///   },
///   message: 'ZIP code required for US addresses',
///   dependencies: ['country'],
/// )
/// ```
class ConditionalValidator<T> extends Validator<T> {
  /// The predicate function that determines if validation should be applied.
  final FuturePredicate<T> predicate;

  /// The error message to display when validation fails.
  final String message;

  /// List of form field keys this validator depends on.
  final List<FormKey> dependencies;

  /// Creates a [ConditionalValidator] with the specified predicate and dependencies.
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

/// A function type for building custom validators.
///
/// Parameters:
/// - [value] (`T?`): The value to validate.
///
/// Returns a `FutureOr<ValidationResult?>` that is null for valid values.
typedef ValidatorBuilderFunction<T> = FutureOr<ValidationResult?> Function(
    T? value);

/// A validator that uses a custom builder function for validation logic.
///
/// [ValidatorBuilder] provides a flexible way to create validators using
/// inline functions or custom validation logic without extending the Validator class.
///
/// Example:
/// ```dart
/// ValidatorBuilder<String>(
///   (value) {
///     if (value != null && value.contains('@')) {
///       return null; // Valid
///     }
///     return InvalidResult('Must contain @');
///   },
/// )
/// ```
class ValidatorBuilder<T> extends Validator<T> {
  /// The function that performs the validation.
  final ValidatorBuilderFunction<T> builder;

  /// List of form field keys this validator depends on.
  final List<FormKey> dependencies;

  /// Creates a [ValidatorBuilder] with the specified builder function.
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

/// A validator that negates the result of another validator.
///
/// [NotValidator] inverts the validation logic - it passes when the wrapped
/// validator fails and fails when the wrapped validator passes. Useful for
/// creating exclusion rules.
///
/// Example:
/// ```dart
/// NotValidator(
///   EmailValidator(),
///   message: 'Must not be an email address',
/// )
/// ```
class NotValidator<T> extends Validator<T> {
  /// The validator whose result will be negated.
  final Validator<T> validator;

  /// Custom error message, or null to use default localized message.
  final String?
      message; // if null, use default message from ShadcnLocalizations

  /// Creates a [NotValidator] that negates the result of another validator.
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

/// A validator that combines multiple validators with OR logic.
///
/// [OrValidator] passes if at least one of the wrapped validators passes.
/// Only fails if all validators fail. Useful for accepting multiple valid formats.
///
/// Example:
/// ```dart
/// OrValidator([
///   EmailValidator(),
///   PhoneValidator(),
/// ])
/// ```
class OrValidator<T> extends Validator<T> {
  /// The list of validators to combine with OR logic.
  final List<Validator<T>> validators;

  /// Creates an [OrValidator] from a list of validators.
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

/// A validator that ensures a value is not null.
///
/// [NonNullValidator] is a simple validator that fails if the value is null.
/// Commonly used to mark fields as required.
///
/// Example:
/// ```dart
/// NonNullValidator<String>(
///   message: 'This field is required',
/// )
/// ```
class NonNullValidator<T> extends Validator<T> {
  /// Custom error message, or null to use default localized message.
  final String?
      message; // if null, use default message from ShadcnLocalizations

  /// Creates a [NonNullValidator] with an optional custom message.
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

/// A validator that ensures a string is not null or empty.
///
/// [NotEmptyValidator] extends [NonNullValidator] to also check for empty strings.
/// Commonly used for text field validation.
///
/// Example:
/// ```dart
/// NotEmptyValidator(
///   message: 'Please enter a value',
/// )
/// ```
class NotEmptyValidator extends NonNullValidator<String> {
  /// Creates a [NotEmptyValidator] with an optional custom message.
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

/// A validator that checks if a string's length is within specified bounds.
///
/// [LengthValidator] validates that a string's length falls within the minimum
/// and/or maximum bounds. Either bound can be null to check only one direction.
///
/// Example:
/// ```dart
/// LengthValidator(
///   min: 3,
///   max: 20,
///   message: 'Must be between 3 and 20 characters',
/// )
/// ```
class LengthValidator extends Validator<String> {
  /// Minimum length requirement (inclusive), or null for no minimum.
  final int? min;

  /// Maximum length requirement (inclusive), or null for no maximum.
  final int? max;

  /// Custom error message, or null to use default localized message.
  final String?
      message; // if null, use default message from ShadcnLocalizations

  /// Creates a [LengthValidator] with optional min/max bounds.
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

/// Defines comparison operators for numeric validation.
///
/// Used by [CompareValidator] to specify the type of comparison to perform.
enum CompareType {
  /// Value must be greater than the compared value.
  greater,

  /// Value must be greater than or equal to the compared value.
  greaterOrEqual,

  /// Value must be less than the compared value.
  less,

  /// Value must be less than or equal to the compared value.
  lessOrEqual,

  /// Value must be equal to the compared value.
  equal
}

/// A validator that compares a field's value with another form field's value.
///
/// [CompareWith] validates by comparing the current field's value against
/// another field identified by a [FormKey]. Supports various comparison types
/// including equality, greater than, less than, etc.
///
/// Example:
/// ```dart
/// CompareWith.greaterOrEqual(
///   FormKey<int>('minAge'),
///   message: 'Must be at least the minimum age',
/// )
/// ```
class CompareWith<T extends Comparable<T>> extends Validator<T> {
  /// The form field key to compare against.
  final FormKey<T> key;

  /// The type of comparison to perform.
  final CompareType type;

  /// Custom error message, or null to use default localized message.
  final String?
      message; // if null, use default message from ShadcnLocalizations

  /// Creates a [CompareWith] validator with the specified comparison type.
  const CompareWith(this.key, this.type, {this.message});

  /// Creates a validator that checks for equality with another field.
  const CompareWith.equal(this.key, {this.message}) : type = CompareType.equal;

  /// Creates a validator that checks if value is greater than another field.
  const CompareWith.greater(this.key, {this.message})
      : type = CompareType.greater;

  /// Creates a validator that checks if value is greater than or equal to another field.
  const CompareWith.greaterOrEqual(this.key, {this.message})
      : type = CompareType.greaterOrEqual;

  /// Creates a validator that checks if value is less than another field.
  const CompareWith.less(this.key, {this.message}) : type = CompareType.less;

  /// Creates a validator that checks if value is less than or equal to another field.
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

/// A validator for ensuring password strength and security requirements.
///
/// [SafePasswordValidator] checks passwords against common security criteria:
/// digits, lowercase letters, uppercase letters, and special characters.
/// Each requirement can be individually enabled or disabled.
///
/// Example:
/// ```dart
/// SafePasswordValidator(
///   requireDigit: true,
///   requireLowercase: true,
///   requireUppercase: true,
///   requireSpecialChar: true,
///   message: 'Password must meet security requirements',
/// )
/// ```
class SafePasswordValidator extends Validator<String> {
  /// Custom error message, or null to use default localized messages.
  final String?
      message; // if null, use default message from ShadcnLocalizations

  /// Whether password must contain at least one digit.
  final bool requireDigit;

  /// Whether password must contain at least one lowercase letter.
  final bool requireLowercase;

  /// Whether password must contain at least one uppercase letter.
  final bool requireUppercase;

  /// Whether password must contain at least one special character.
  final bool requireSpecialChar;

  /// Creates a [SafePasswordValidator] with configurable requirements.
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

/// A validator that checks if a numeric value meets a minimum threshold.
///
/// [MinValidator] ensures that numeric values are greater than (or equal to)
/// a specified minimum value. Useful for enforcing minimum quantities, ages, etc.
///
/// Example:
/// ```dart
/// MinValidator<int>(
///   18,
///   inclusive: true,
///   message: 'Must be at least 18 years old',
/// )
/// ```
class MinValidator<T extends num> extends Validator<T> {
  /// The minimum acceptable value.
  final T min;

  /// Whether the minimum value itself is acceptable (true) or must be exceeded (false).
  final bool inclusive;

  /// Custom error message, or null to use default localized message.
  final String?
      message; // if null, use default message from ShadcnLocalizations

  /// Creates a [MinValidator] with the specified minimum value.
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

/// A validator that checks if a numeric value does not exceed a maximum threshold.
///
/// [MaxValidator] ensures that numeric values are less than (or equal to)
/// a specified maximum value. Useful for enforcing maximum quantities, limits, etc.
///
/// Example:
/// ```dart
/// MaxValidator<int>(
///   100,
///   inclusive: true,
///   message: 'Must not exceed 100',
/// )
/// ```
class MaxValidator<T extends num> extends Validator<T> {
  /// The maximum acceptable value.
  final T max;

  /// Whether the maximum value itself is acceptable (true) or must not be reached (false).
  final bool inclusive;

  /// Custom error message, or null to use default localized message.
  final String?
      message; // if null, use default message from ShadcnLocalizations

  /// Creates a [MaxValidator] with the specified maximum value.
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

/// A validator that checks if a numeric value falls within a specified range.
///
/// [RangeValidator] ensures values are between minimum and maximum bounds.
/// Both bounds can be inclusive or exclusive depending on configuration.
///
/// Example:
/// ```dart
/// RangeValidator<double>(
///   0.0,
///   100.0,
///   inclusive: true,
///   message: 'Must be between 0 and 100',
/// )
/// ```
class RangeValidator<T extends num> extends Validator<T> {
  /// The minimum acceptable value.
  final T min;

  /// The maximum acceptable value.
  final T max;

  /// Whether the bounds are inclusive (true) or exclusive (false).
  final bool inclusive;

  /// Custom error message, or null to use default localized message.
  final String?
      message; // if null, use default message from ShadcnLocalizations

  /// Creates a [RangeValidator] with the specified min and max bounds.
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

/// A validator that checks if a string matches a regular expression pattern.
///
/// [RegexValidator] provides flexible pattern-based validation using regular
/// expressions. Useful for validating formats like phone numbers, postal codes, etc.
///
/// Example:
/// ```dart
/// RegexValidator(
///   RegExp(r'^\d{3}-\d{3}-\d{4}$'),
///   message: 'Must be in format: XXX-XXX-XXXX',
/// )
/// ```
class RegexValidator extends Validator<String> {
  /// The regular expression pattern to match against.
  final RegExp pattern;

  /// Custom error message, or null to use default localized message.
  final String?
      message; // if null, use default message from ShadcnLocalizations

  /// Creates a [RegexValidator] with the specified pattern.
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

/// A validator that checks if a string is a valid email address.
///
/// [EmailValidator] uses the email_validator package to validate email
/// addresses according to standard email format rules.
///
/// Example:
/// ```dart
/// EmailValidator(
///   message: 'Please enter a valid email address',
/// )
/// ```
class EmailValidator extends Validator<String> {
  /// Custom error message, or null to use default localized message.
  final String?
      message; // if null, use default message from ShadcnLocalizations

  /// Creates an [EmailValidator] with an optional custom message.
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

/// A validator that checks if a string is a valid URL.
///
/// [URLValidator] validates URLs using Dart's Uri parsing capabilities
/// to ensure the string represents a valid web address.
///
/// Example:
/// ```dart
/// URLValidator(
///   message: 'Please enter a valid URL',
/// )
/// ```
class URLValidator extends Validator<String> {
  /// Custom error message, or null to use default localized message.
  final String?
      message; // if null, use default message from ShadcnLocalizations

  /// Creates a [URLValidator] with an optional custom message.
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

/// A validator that compares a value against a static comparison value.
///
/// [CompareTo] validates by comparing the field value against a fixed value
/// (unlike [CompareWith] which compares against another field). Supports
/// various comparison types.
///
/// Example:
/// ```dart
/// CompareTo.greaterOrEqual(
///   18,
///   message: 'Must be at least 18',
/// )
/// ```
class CompareTo<T extends Comparable<T>> extends Validator<T> {
  /// The value to compare against.
  final T? value;

  /// The type of comparison to perform.
  final CompareType type;

  /// Custom error message, or null to use default localized message.
  final String?
      message; // if null, use default message from ShadcnLocalizations

  /// Creates a [CompareTo] validator with the specified comparison type.
  const CompareTo(this.value, this.type, {this.message});

  /// Creates a validator that checks for equality with a value.
  const CompareTo.equal(this.value, {this.message}) : type = CompareType.equal;

  /// Creates a validator that checks if field value is greater than the specified value.
  const CompareTo.greater(this.value, {this.message})
      : type = CompareType.greater;

  /// Creates a validator that checks if field value is greater than or equal to the specified value.
  const CompareTo.greaterOrEqual(this.value, {this.message})
      : type = CompareType.greaterOrEqual;

  /// Creates a validator that checks if field value is less than the specified value.
  const CompareTo.less(this.value, {this.message}) : type = CompareType.less;

  /// Creates a validator that checks if field value is less than or equal to the specified value.
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

/// A validator that combines multiple validators with AND logic.
///
/// [CompositeValidator] runs multiple validators sequentially and only passes
/// if all validators pass. If any validator fails, validation stops and returns
/// that error. Created automatically when using the `&` operator between validators.
///
/// Example:
/// ```dart
/// CompositeValidator([
///   NonNullValidator(),
///   MinLengthValidator(3),
///   EmailValidator(),
/// ])
/// ```
class CompositeValidator<T> extends Validator<T> {
  /// The list of validators to run sequentially.
  final List<Validator<T>> validators;

  /// Creates a [CompositeValidator] from a list of validators.
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

/// Abstract base class representing the result of a validation operation.
///
/// [ValidationResult] encapsulates the outcome of validating a form field value.
/// Subclasses include [InvalidResult] for validation failures and [ValidResult]
/// for successful validation.
abstract class ValidationResult {
  /// The form validation mode that triggered this result.
  final FormValidationMode state;

  /// Creates a [ValidationResult] with the specified validation state.
  const ValidationResult({required this.state});

  /// The form field key associated with this validation result.
  FormKey get key;

  /// Attaches a form field key to this validation result.
  ValidationResult attach(FormKey key);
}

/// A validation result that indicates a value should be replaced.
///
/// [ReplaceResult] is used when validation determines that the submitted
/// value should be transformed or replaced with a different value. For example,
/// trimming whitespace or formatting input.
class ReplaceResult<T> extends ValidationResult {
  /// The replacement value to use.
  final T value;

  final FormKey? _key;

  /// Creates a [ReplaceResult] with the specified replacement value.
  const ReplaceResult(this.value, {required super.state}) : _key = null;

  /// Creates a [ReplaceResult] already attached to a form field key.
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

/// A validation result indicating that validation failed.
///
/// [InvalidResult] contains an error message describing why validation failed.
/// This is the most common validation result type returned by validators when
/// a value doesn't meet the validation criteria.
class InvalidResult extends ValidationResult {
  /// The error message describing the validation failure.
  final String message;

  final FormKey? _key;

  /// Creates an [InvalidResult] with the specified error message.
  const InvalidResult(this.message, {required super.state}) : _key = null;

  /// Creates an [InvalidResult] already attached to a form field key.
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

/// A notification sent when a form field's validation state changes.
///
/// [FormValidityNotification] is dispatched through the notification system
/// when a field's validity transitions between valid, invalid, or null states.
/// Useful for updating UI or tracking form validation status.
class FormValidityNotification extends Notification {
  /// The previous validation result, or null if there was none.
  final ValidationResult? oldValidity;

  /// The new validation result, or null if now valid.
  final ValidationResult? newValidity;

  /// Creates a [FormValidityNotification] with old and new validity states.
  const FormValidityNotification(this.newValidity, this.oldValidity);
}

/// A key that uniquely identifies a form field and its type.
///
/// [FormKey] extends [LocalKey] and is used throughout the form system to
/// reference specific form fields. It includes type information to ensure
/// type-safe access to form values.
///
/// Example:
/// ```dart
/// const emailKey = FormKey<String>('email');
/// const ageKey = FormKey<int>('age');
/// ```
class FormKey<T> extends LocalKey {
  /// The underlying key object.
  final Object key;

  /// Creates a [FormKey] with the specified key object.
  const FormKey(this.key);

  /// Gets the generic type parameter of this key.
  Type get type => T;

  /// Checks if a dynamic value is an instance of this key's type.
  bool isInstanceOf(dynamic value) {
    return value is T;
  }

  /// Gets the value associated with this key from the form values map.
  T? getValue(FormMapValues values) {
    return values.getValue(this);
  }

  /// Operator overload to get the value from form values (same as [getValue]).
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

// Type aliases for form field keys

/// Form key type for autocomplete fields with string values.
typedef AutoCompleteKey = FormKey<String>;

/// Form key type for checkbox fields with [CheckboxState] values.
typedef CheckboxKey = FormKey<CheckboxState>;

/// Form key type for chip input fields with list values.
typedef ChipInputKey<T> = FormKey<List<T>>;

/// Form key type for color picker fields with [Color] values.
typedef ColorPickerKey = FormKey<Color>;

/// Form key type for date picker fields with [DateTime] values.
typedef DatePickerKey = FormKey<DateTime>;

/// Form key type for date input fields with [DateTime] values.
typedef DateInputKey = FormKey<DateTime>;

/// Form key type for duration picker fields with [Duration] values.
typedef DurationPickerKey = FormKey<Duration>;

/// Form key type for duration input fields with [Duration] values.
typedef DurationInputKey = FormKey<Duration>;

/// Form key type for text input fields with string values.
typedef InputKey = FormKey<String>;

/// Form key type for OTP input fields with lists of nullable integers.
typedef InputOTPKey = FormKey<List<int?>>;

/// Form key type for multi-select fields with iterable values.
typedef MultiSelectKey<T> = FormKey<Iterable<T>>;

/// Form key type for multiple answer fields with iterable values.
typedef MultipleAnswerKey<T> = FormKey<Iterable<T>>;

/// Form key type for multiple choice fields with single selected values.
typedef MultipleChoiceKey<T> = FormKey<T>;

/// Form key type for number input fields with numeric values.
typedef NumberInputKey = FormKey<num>;

/// Form key type for phone input fields with [PhoneNumber] values.
typedef PhoneInputKey = FormKey<PhoneNumber>;

/// Form key type for radio card fields with integer index values.
typedef RadioCardKey = FormKey<int>;

/// Form key type for radio group fields with integer index values.
typedef RadioGroupKey = FormKey<int>;

/// Form key type for select dropdown fields with typed values.
typedef SelectKey<T> = FormKey<T>;

/// Form key type for slider fields with [SliderValue] values.
typedef SliderKey = FormKey<SliderValue>;

/// Form key type for star rating fields with double values.
typedef StarRatingKey = FormKey<double>;

/// Form key type for switch fields with boolean values.
typedef SwitchKey = FormKey<bool>;

/// Form key type for text area fields with string values.
typedef TextAreaKey = FormKey<String>;

/// Form key type for text field inputs with string values.
typedef TextFieldKey = FormKey<String>;

/// Form key type for time picker fields with [TimeOfDay] values.
typedef TimePickerKey = FormKey<TimeOfDay>;

/// Form key type for time input fields with [TimeOfDay] values.
typedef TimeInputKey = FormKey<TimeOfDay>;

/// Form key type for toggle fields with boolean values.
typedef ToggleKey = FormKey<bool>;

/// A form field entry that wraps a form widget with validation.
///
/// [FormEntry] associates a [FormKey] with a form field widget and optional
/// validator. It integrates with the form state management system to track
/// field values and validation states.
class FormEntry<T> extends StatefulWidget {
  /// The form field widget to wrap.
  final Widget child;

  /// Optional validator function for this form field.
  ///
  /// Called when form validation is triggered. Should return `null` for valid
  /// values or a validation error message for invalid values.
  final Validator<T>? validator;

  /// Creates a form entry with a typed key.
  ///
  /// The [key] parameter must be a [FormKey<T>] to ensure type safety.
  const FormEntry(
      {required FormKey<T> super.key, required this.child, this.validator});

  @override
  FormKey get key => super.key as FormKey;

  @override
  State<FormEntry> createState() => FormEntryState();
}

/// Interface for form field state management.
///
/// Provides methods and properties for managing form field lifecycle, validation,
/// and value reporting. Typically mixed into state classes that participate in
/// form validation and submission workflows.
///
/// Implementations should:
/// - Track mount state to prevent operations on disposed widgets
/// - Report value changes to parent forms
/// - Support both synchronous and asynchronous validation
mixin FormFieldHandle {
  /// Whether the widget is currently mounted in the widget tree.
  bool get mounted;

  /// The unique key identifying this field within its form.
  FormKey get formKey;

  /// Reports a new value to the form and triggers validation.
  ///
  /// Parameters:
  /// - [value] (`T?`, required): The new field value.
  ///
  /// Returns: `FutureOr<ValidationResult?>` — validation result if applicable.
  FutureOr<ValidationResult?> reportNewFormValue<T>(T? value);

  /// Re-runs validation on the current value.
  ///
  /// Returns: `FutureOr<ValidationResult?>` — validation result if applicable.
  FutureOr<ValidationResult?> revalidate();

  /// A listenable for the current validation state.
  ///
  /// Returns `null` if no validation has been performed or if validation passed.
  ValueListenable<ValidationResult?>? get validity;
}

class _FormEntryCachedValue {
  Object? value;

  _FormEntryCachedValue(this.value);
}

/// State class for [FormEntry] widgets.
///
/// Manages form field lifecycle and integrates with parent [FormController]
/// for validation and value reporting.
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

/// A widget that intercepts form value reports.
///
/// Wraps a form field to observe value changes before they reach the parent form.
/// Useful for implementing side effects like logging, analytics, or derived state
/// updates when form field values change.
///
/// Example:
/// ```dart
/// FormEntryInterceptor<String>(
///   onValueReported: (value) => print('Email changed: $value'),
///   child: TextFormField(),
/// )
/// ```
class FormEntryInterceptor<T> extends StatefulWidget {
  /// The child widget (typically a form field).
  final Widget child;

  /// Callback invoked when a value is reported by the child field.
  final ValueChanged<T>? onValueReported;

  /// Creates a [FormEntryInterceptor].
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): The form field to wrap.
  /// - [onValueReported] (`ValueChanged<T>?`, optional): Called with new values.
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

/// Holds the current value and validator for a form field.
///
/// Immutable snapshot of a form field's state used internally by form controllers
/// to track field values and their associated validation rules.
class FormValueState<T> {
  /// The current field value.
  final T? value;

  /// The validator function for this field.
  final Validator<T>? validator;

  /// Creates a [FormValueState].
  ///
  /// Parameters:
  /// - [value] (`T?`, optional): Current field value.
  /// - [validator] (`Validator<T>?`, optional): Validation function.
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

/// A map of form field keys to their values.
///
/// Used to collect and pass around form data, where each key uniquely identifies
/// a form field and maps to its current value.
typedef FormMapValues = Map<FormKey, dynamic>;

/// Callback function for form submission.
///
/// Parameters:
/// - [context] (`BuildContext`): The build context.
/// - [values] (`FormMapValues`): Map of all form field values.
typedef FormSubmitCallback = void Function(
    BuildContext context, FormMapValues values);

/// Extension methods for [FormMapValues].
extension FormMapValuesExtension on FormMapValues {
  /// Retrieves a typed value for a specific form key.
  ///
  /// Parameters:
  /// - [key] (`FormKey<T>`, required): The form key to look up.
  ///
  /// Returns: `T?` — the value if found and correctly typed, null otherwise.
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
  /// Returns a `Map<FormKey, Object?>` where each key corresponds to a form field
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
  /// or `Future<ValidationResult?>` for asynchronous validation.
  ///
  /// Returns a `Map<FormKey, FutureOr<ValidationResult?>>` representing the
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
  /// Returns a `Map<FormKey, ValidationResult>` containing only fields with errors.
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

  /// Retrieves the current value for a specific form field.
  ///
  /// Parameters:
  /// - [key] (`FormKey<T>`, required): The form key to look up.
  ///
  /// Returns: `T?` — the field value if exists, null otherwise.
  T? getValue<T>(FormKey<T> key) {
    return _attachedInputs[key]?.value as T?;
  }

  /// Checks if a form field has a non-null value.
  ///
  /// Parameters:
  /// - [key] (`FormKey`, required): The form key to check.
  ///
  /// Returns: `bool` — true if field has a value, false otherwise.
  bool hasValue(FormKey key) {
    return _attachedInputs[key]?.value != null;
  }

  /// Revalidates all form fields with validators.
  ///
  /// Runs validation on all registered fields and updates their validation states.
  /// Supports both synchronous and asynchronous validators.
  ///
  /// Parameters:
  /// - [context] (`BuildContext`, required): The build context.
  /// - [state] (`FormValidationMode`, required): Validation mode to use.
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

  /// Attaches a form field to this controller.
  ///
  /// Registers the field and runs initial validation if a validator is provided.
  /// Manages field lifecycle transitions (initial → changed) and coordinates
  /// revalidation of dependent fields.
  ///
  /// Parameters:
  /// - [context] (`BuildContext`, required): The build context.
  /// - [handle] (`FormFieldHandle`, required): The field handle to attach.
  /// - [value] (`Object?`, required): Current field value.
  /// - [validator] (`Validator?`, optional): Validation function.
  /// - [forceRevalidate] (`bool`, default: `false`): Force revalidation even if unchanged.
  ///
  /// Returns: `FutureOr<ValidationResult?>` — validation result if applicable.
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

/// State class for the [Form] widget that manages form controller lifecycle.
///
/// This state class is responsible for initializing and updating the
/// [FormController] used by the [Form] widget. It ensures proper controller
/// management when the controller property changes and provides the controller
/// to descendant widgets through the data inheritance mechanism.
///
/// The state handles two scenarios:
/// - Creates a default [FormController] if none is provided
/// - Updates to a new controller when the widget's controller property changes
///
/// See also:
/// - [Form], the widget that uses this state
/// - [FormController], the controller managed by this state
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

/// Widget builder for displaying form entry validation errors.
///
/// Conditionally renders error messages based on validation state and modes.
class FormEntryErrorBuilder extends StatelessWidget {
  /// Builder function that creates the error display widget.
  final Widget Function(
      BuildContext context, ValidationResult? error, Widget? child) builder;

  /// Optional child widget passed to the builder.
  final Widget? child;

  /// Validation modes that trigger error display.
  final Set<FormValidationMode>? modes;

  /// Creates a form entry error builder.
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

/// Validation result indicating a validation is in progress.
///
/// Used when asynchronous validation is being performed and the result
/// is not yet available.
class WaitingResult extends ValidationResult {
  final FormKey? _key;

  /// Creates a waiting result attached to a form key.
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

/// Widget builder for displaying form-wide validation errors.
///
/// Provides access to all form validation errors for rendering error summaries.
class FormErrorBuilder extends StatelessWidget {
  /// Optional child widget passed to the builder.
  final Widget? child;

  /// Builder function that creates the error display from all form errors.
  final Widget Function(BuildContext context,
      Map<FormKey, ValidationResult> errors, Widget? child) builder;

  /// Creates a form error builder.
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

/// Builder function type for displaying pending form validations.
///
/// Takes the context, map of pending validation futures, and optional child widget.
typedef FormPendingWidgetBuilder = Widget Function(BuildContext context,
    Map<FormKey, Future<ValidationResult?>> errors, Widget? child);

/// Widget builder for displaying pending form validations.
///
/// Shows feedback while asynchronous validations are in progress.
class FormPendingBuilder extends StatelessWidget {
  /// Optional child widget passed to the builder.
  final Widget? child;

  /// Builder function for creating pending validation display.
  final FormPendingWidgetBuilder builder;

  /// Creates a form pending builder.
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

/// Extension methods on [BuildContext] for form operations.
extension FormExtension on BuildContext {
  /// Gets the current value for a form field by key.
  ///
  /// Returns null if the form or field is not found.
  T? getFormValue<T>(FormKey<T> key) {
    final formController = Data.maybeFind<FormController>(this);
    if (formController != null) {
      final state = formController.getValue(key);
      return state;
    }
    return null;
  }

  /// Submits the form and triggers validation.
  ///
  /// Returns a [SubmissionResult] with form values and any validation errors.
  /// May return a Future if asynchronous validation is in progress.
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

/// Mixin that provides form value management for stateful widgets.
///
/// Integrates a widget with the form system, managing value updates,
/// validation, and form state synchronization.
mixin FormValueSupplier<T, X extends StatefulWidget> on State<X> {
  _FormEntryCachedValue? _cachedValue;
  int _futureCounter = 0;
  FormFieldHandle? _entryState;

  /// Gets the current form value.
  T? get formValue => _cachedValue?.value as T?;

  /// Sets a new form value and triggers validation.
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

  /// Called when a form value is replaced by validation logic.
  ///
  /// Subclasses should override this to handle value replacements.
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

/// Result of a form submission containing values and validation errors.
///
/// Returned when a form is submitted, containing all field values
/// and any validation errors that occurred.
class SubmissionResult {
  /// Map of form field values keyed by their FormKey.
  final Map<FormKey, Object?> values;

  /// Map of validation errors keyed by their FormKey.
  final Map<FormKey, ValidationResult> errors;

  /// Creates a submission result.
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

/// A standard form field widget with label, validation, and error display.
///
/// Provides a consistent layout for form inputs with labels, hints,
/// validation, and error messaging.
class FormField<T> extends StatelessWidget {
  /// The label widget for the form field.
  final Widget label;

  /// Optional hint text displayed below the field.
  final Widget? hint;

  /// The main input widget.
  final Widget child;

  /// Optional widget displayed before the label.
  final Widget? leadingLabel;

  /// Optional widget displayed after the label.
  final Widget? trailingLabel;

  /// Alignment of the label axis.
  final MainAxisAlignment? labelAxisAlignment;

  /// Gap between leading label and main label.
  final double? leadingGap;

  /// Gap between main label and trailing label.
  final double? trailingGap;

  /// Padding around the form field.
  final EdgeInsetsGeometry? padding;

  /// Validator function for this field.
  final Validator<T>? validator;

  /// Validation modes that trigger error display.
  final Set<FormValidationMode>? showErrors;

  /// Creates a form field.
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

/// An inline form field widget with label next to the input.
///
/// Provides a compact horizontal layout for form inputs with labels
/// and validation.
class FormInline<T> extends StatelessWidget {
  /// The label widget for the form field.
  final Widget label;

  /// Optional hint text displayed below the field.
  final Widget? hint;

  /// The main input widget.
  final Widget child;

  /// Validator function for this field.
  final Validator<T>? validator;

  /// Validation modes that trigger error display.
  final Set<FormValidationMode>? showErrors;

  /// Creates an inline form field.
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

/// A table-based layout for multiple form fields.
///
/// Arranges form fields in a table layout for structured data entry.
class FormTableLayout extends StatelessWidget {
  /// List of form field rows to display in the table.
  final List<FormField> rows;

  /// Vertical spacing between rows.
  final double? spacing;

  /// Creates a [FormTableLayout].
  ///
  /// Parameters:
  /// - [rows] (`List<FormField>`, required): Form fields to arrange in rows.
  /// - [spacing] (`double?`, optional): Custom row spacing.
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
                    .sized(height: 32 * scaling)
                    .withPadding(
                      top: i == 0 ? 0 : spacing,
                      right: 16 * scaling,
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

/// A button that automatically handles form submission states.
///
/// Renders different content based on form validation state:
/// - Default: Shows [child] with optional leading/trailing widgets
/// - Loading: Shows [loading] during async validation
/// - Error: Shows [error] when validation fails
///
/// Automatically disables during validation and enables when form is valid.
///
/// Example:
/// ```dart
/// SubmitButton(
///   child: Text('Submit'),
///   loading: Text('Validating...'),
///   error: Text('Fix errors'),
/// )
/// ```
class SubmitButton extends StatelessWidget {
  /// Button style configuration.
  final AbstractButtonStyle? style;

  /// Default button content.
  final Widget child;

  /// Content shown during async validation (loading state).
  final Widget? loading;

  /// Content shown when validation errors exist.
  final Widget? error;

  /// Leading widget in default state.
  final Widget? leading;

  /// Trailing widget in default state.
  final Widget? trailing;

  /// Leading widget in loading state.
  final Widget? loadingLeading;

  /// Trailing widget in loading state.
  final Widget? loadingTrailing;

  /// Leading widget in error state.
  final Widget? errorLeading;

  /// Trailing widget in error state.
  final Widget? errorTrailing;

  /// Content alignment within the button.
  final AlignmentGeometry? alignment;

  /// Whether to disable hover effects.
  final bool disableHoverEffect;

  /// Whether the button is enabled (null uses form state).
  final bool? enabled;

  /// Whether to enable haptic feedback on press.
  final bool? enableFeedback;

  /// Whether to disable state transition animations.
  final bool disableTransition;

  /// Focus node for keyboard navigation.
  final FocusNode? focusNode;

  /// Creates a [SubmitButton].
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): Default button content.
  /// - [style] (`AbstractButtonStyle?`, optional): Button styling.
  /// - [loading] (`Widget?`, optional): Loading state content.
  /// - [error] (`Widget?`, optional): Error state content.
  /// - [leading] (`Widget?`, optional): Leading widget (default state).
  /// - [trailing] (`Widget?`, optional): Trailing widget (default state).
  /// - [loadingLeading] (`Widget?`, optional): Leading widget (loading state).
  /// - [loadingTrailing] (`Widget?`, optional): Trailing widget (loading state).
  /// - [errorLeading] (`Widget?`, optional): Leading widget (error state).
  /// - [errorTrailing] (`Widget?`, optional): Trailing widget (error state).
  /// - [alignment] (`AlignmentGeometry?`, optional): Content alignment.
  /// - [disableHoverEffect] (`bool`, default: `false`): Disable hover.
  /// - [enabled] (`bool?`, optional): Override enabled state.
  /// - [enableFeedback] (`bool?`, optional): Enable haptic feedback.
  /// - [disableTransition] (`bool`, default: `false`): Disable animations.
  /// - [focusNode] (`FocusNode?`, optional): Focus node.
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
