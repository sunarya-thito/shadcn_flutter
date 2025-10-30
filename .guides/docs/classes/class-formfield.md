---
title: "Class: FormField"
description: "A standard form field widget with label, validation, and error display."
---

```dart
/// A standard form field widget with label, validation, and error display.
///
/// Provides a consistent layout for form inputs with labels, hints,
/// validation, and error messaging.
class FormField<T> extends StatelessWidget {
  /// The label widget for the form field.
  final Widget label;
  /// Optional hint text displayed below the field.
  final Widget? hint;
  /// The main input widget.
  final Widget child;
  /// Optional widget displayed before the label.
  final Widget? leadingLabel;
  /// Optional widget displayed after the label.
  final Widget? trailingLabel;
  /// Alignment of the label axis.
  final MainAxisAlignment? labelAxisAlignment;
  /// Gap between leading label and main label.
  final double? leadingGap;
  /// Gap between main label and trailing label.
  final double? trailingGap;
  /// Padding around the form field.
  final EdgeInsetsGeometry? padding;
  /// Validator function for this field.
  final Validator<T>? validator;
  /// Validation modes that trigger error display.
  final Set<FormValidationMode>? showErrors;
  /// Creates a form field.
  const FormField({required FormKey<T> super.key, required this.label, required this.child, this.leadingLabel, this.trailingLabel, this.labelAxisAlignment = MainAxisAlignment.start, this.leadingGap, this.trailingGap, this.padding = EdgeInsets.zero, this.validator, this.hint, this.showErrors});
  FormKey<T> get key;
  Widget build(BuildContext context);
}
```
