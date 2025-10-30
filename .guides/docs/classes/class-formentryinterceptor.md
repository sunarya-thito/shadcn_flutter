---
title: "Class: FormEntryInterceptor"
description: "A widget that intercepts form value reports."
---

```dart
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
  const FormEntryInterceptor({super.key, required this.child, this.onValueReported});
  State<FormEntryInterceptor<T>> createState();
}
```
