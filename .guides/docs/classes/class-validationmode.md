---
title: "Class: ValidationMode"
description: "A validator wrapper that controls when validation occurs based on form lifecycle."
---

```dart
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
  const ValidationMode(this.validator, {this.mode = const {FormValidationMode.changed, FormValidationMode.submitted, FormValidationMode.initial}});
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode lifecycle);
  void operator ==(Object other);
  int get hashCode;
}
```
