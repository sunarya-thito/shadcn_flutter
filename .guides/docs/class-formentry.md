---
title: "Class: FormEntry"
description: "Reference for FormEntry"
---

```dart
class FormEntry<T> extends StatefulWidget {
  final Widget child;
  final Validator<T>? validator;
  const FormEntry({required FormKey<T> super.key, required this.child, this.validator});
  FormKey get key;
  State<FormEntry> createState();
}
```
