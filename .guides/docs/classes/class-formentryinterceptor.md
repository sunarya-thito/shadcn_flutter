---
title: "Class: FormEntryInterceptor"
description: "Reference for FormEntryInterceptor"
---

```dart
class FormEntryInterceptor<T> extends StatefulWidget {
  final Widget child;
  final ValueChanged<T>? onValueReported;
  const FormEntryInterceptor({super.key, required this.child, this.onValueReported});
  State<FormEntryInterceptor<T>> createState();
}
```
