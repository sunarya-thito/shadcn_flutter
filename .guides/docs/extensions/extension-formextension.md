---
title: "Extension: FormExtension"
description: "Extension methods on [BuildContext] for form operations."
---

```dart
/// Extension methods on [BuildContext] for form operations.
extension FormExtension on BuildContext {
  /// Gets the current value for a form field by key.
  ///
  /// Returns null if the form or field is not found.
  T? getFormValue<T>(FormKey<T> key);
  /// Submits the form and triggers validation.
  ///
  /// Returns a [SubmissionResult] with form values and any validation errors.
  /// May return a Future if asynchronous validation is in progress.
  FutureOr<SubmissionResult> submitForm();
}
```
