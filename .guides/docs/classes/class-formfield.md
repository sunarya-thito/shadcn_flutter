---
title: "Class: FormField"
description: "Reference for FormField"
---

```dart
class FormField<T> extends StatelessWidget {
  final Widget label;
  final Widget? hint;
  final Widget child;
  final Widget? leadingLabel;
  final Widget? trailingLabel;
  final MainAxisAlignment? labelAxisAlignment;
  final double? leadingGap;
  final double? trailingGap;
  final EdgeInsetsGeometry? padding;
  final Validator<T>? validator;
  final Set<FormValidationMode>? showErrors;
  const FormField({required FormKey<T> super.key, required this.label, required this.child, this.leadingLabel, this.trailingLabel, this.labelAxisAlignment = MainAxisAlignment.start, this.leadingGap, this.trailingGap, this.padding = EdgeInsets.zero, this.validator, this.hint, this.showErrors});
  FormKey<T> get key;
  Widget build(BuildContext context);
}
```
