---
title: "Class: Validator"
description: "Abstract base class for implementing form field validation logic."
---

```dart
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
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode lifecycle);
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
  Validator<T> combine(Validator<T> other);
  /// Combines this validator with another using AND logic (alias for [combine]).
  ///
  /// This operator provides a convenient syntax for combining validators
  /// where both must pass for validation to succeed.
  ///
  /// Example:
  /// ```dart
  /// final validator = RequiredValidator<String>() & EmailValidator();
  /// ```
  Validator<T> operator &(Validator<T> other);
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
  Validator<T> operator |(Validator<T> other);
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
  Validator<T> operator ~();
  /// Negates this validator's result (alias for `~` operator).
  ///
  /// Provides an alternative syntax for creating negated validators.
  ///
  /// Example:
  /// ```dart
  /// final notEmpty = -EmptyValidator<String>();
  /// ```
  Validator<T> operator -();
  /// Combines this validator with another using AND logic (alias for [combine]).
  ///
  /// Alternative syntax for combining validators where both must pass.
  ///
  /// Example:
  /// ```dart
  /// final validator = requiredValidator + lengthValidator;
  /// ```
  Validator<T> operator +(Validator<T> other);
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
  bool shouldRevalidate(FormKey<dynamic> source);
}
```
