---
title: "Class: ValidationResult"
description: "Abstract base class representing the result of a validation operation."
---

```dart
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
```
