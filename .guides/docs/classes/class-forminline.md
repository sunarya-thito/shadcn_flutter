---
title: "Class: FormInline"
description: "An inline form field widget with label next to the input."
---

```dart
/// An inline form field widget with label next to the input.
///
/// Provides a compact horizontal layout for form inputs with labels
/// and validation.
class FormInline<T> extends StatelessWidget {
  /// The label widget for the form field.
  final Widget label;
  /// Optional hint text displayed below the field.
  final Widget? hint;
  /// The main input widget.
  final Widget child;
  /// Validator function for this field.
  final Validator<T>? validator;
  /// Validation modes that trigger error display.
  final Set<FormValidationMode>? showErrors;
  /// Creates an inline form field.
  const FormInline({required FormKey<T> super.key, required this.label, required this.child, this.validator, this.hint, this.showErrors});
  FormKey<T> get key;
  Widget build(BuildContext context);
}
```
