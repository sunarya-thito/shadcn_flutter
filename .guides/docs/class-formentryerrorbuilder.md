---
title: "Class: FormEntryErrorBuilder"
description: "Reference for FormEntryErrorBuilder"
---

```dart
class FormEntryErrorBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ValidationResult? error, Widget? child) builder;
  final Widget? child;
  final Set<FormValidationMode>? modes;
  const FormEntryErrorBuilder({super.key, required this.builder, this.child, this.modes});
  Widget build(BuildContext context);
}
```
