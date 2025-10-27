---
title: "Class: RadioGroup"
description: "Reference for RadioGroup"
---

```dart
class RadioGroup<T> extends StatefulWidget {
  final Widget child;
  final T? value;
  final ValueChanged<T>? onChanged;
  final bool? enabled;
  const RadioGroup({super.key, required this.child, this.value, this.onChanged, this.enabled});
  RadioGroupState<T> createState();
}
```
