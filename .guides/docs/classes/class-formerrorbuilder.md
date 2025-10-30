---
title: "Class: FormErrorBuilder"
description: "Widget builder for displaying form-wide validation errors."
---

```dart
/// Widget builder for displaying form-wide validation errors.
///
/// Provides access to all form validation errors for rendering error summaries.
class FormErrorBuilder extends StatelessWidget {
  /// Optional child widget passed to the builder.
  final Widget? child;
  /// Builder function that creates the error display from all form errors.
  final Widget Function(BuildContext context, Map<FormKey, ValidationResult> errors, Widget? child) builder;
  /// Creates a form error builder.
  const FormErrorBuilder({super.key, required this.builder, this.child});
  Widget build(BuildContext context);
}
```
