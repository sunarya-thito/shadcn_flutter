---
title: "Class: MultipleChoice"
description: "Reference for MultipleChoice"
---

```dart
class MultipleChoice<T> extends StatefulWidget {
  final Widget child;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final bool? enabled;
  final bool? allowUnselect;
  const MultipleChoice({super.key, required this.child, this.value, this.onChanged, this.enabled, this.allowUnselect});
  State<MultipleChoice<T>> createState();
}
```
