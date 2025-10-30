---
title: "Class: SubmissionResult"
description: "Result of a form submission containing values and validation errors."
---

```dart
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
  String toString();
  bool operator ==(Object other);
  int get hashCode;
}
```
