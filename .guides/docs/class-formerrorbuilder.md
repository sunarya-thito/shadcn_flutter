---
title: "Class: FormErrorBuilder"
description: "Reference for FormErrorBuilder"
---

```dart
class FormErrorBuilder extends StatelessWidget {
  final Widget? child;
  final Widget Function(BuildContext context, Map<FormKey, ValidationResult> errors, Widget? child) builder;
  const FormErrorBuilder({super.key, required this.builder, this.child});
  Widget build(BuildContext context);
}
```
