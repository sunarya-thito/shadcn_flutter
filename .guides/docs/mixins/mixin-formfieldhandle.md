---
title: "Mixin: FormFieldHandle"
description: "Interface for form field state management."
---

```dart
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
```
