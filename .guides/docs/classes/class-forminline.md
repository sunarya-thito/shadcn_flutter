---
title: "Class: FormInline"
description: "Reference for FormInline"
---

```dart
class FormInline<T> extends StatelessWidget {
  final Widget label;
  final Widget? hint;
  final Widget child;
  final Validator<T>? validator;
  final Set<FormValidationMode>? showErrors;
  const FormInline({required FormKey<T> super.key, required this.label, required this.child, this.validator, this.hint, this.showErrors});
  FormKey<T> get key;
  Widget build(BuildContext context);
}
```
