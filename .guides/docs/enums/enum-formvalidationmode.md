---
title: "Enum: FormValidationMode"
description: "Defines when form field validation should occur during the component lifecycle."
---

```dart
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
```
