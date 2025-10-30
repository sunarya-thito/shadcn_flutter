---
title: "Class: FormEntryErrorBuilder"
description: "Widget builder for displaying form entry validation errors."
---

```dart
/// Widget builder for displaying form entry validation errors.
///
/// Conditionally renders error messages based on validation state and modes.
class FormEntryErrorBuilder extends StatelessWidget {
  /// Builder function that creates the error display widget.
  final Widget Function(BuildContext context, ValidationResult? error, Widget? child) builder;
  /// Optional child widget passed to the builder.
  final Widget? child;
  /// Validation modes that trigger error display.
  final Set<FormValidationMode>? modes;
  /// Creates a form entry error builder.
  const FormEntryErrorBuilder({super.key, required this.builder, this.child, this.modes});
  Widget build(BuildContext context);
}
```
