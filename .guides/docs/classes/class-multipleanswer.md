---
title: "Class: MultipleAnswer"
description: "Reference for MultipleAnswer"
---

```dart
class MultipleAnswer<T> extends StatefulWidget {
  final Widget child;
  final Iterable<T>? value;
  final ValueChanged<Iterable<T>?>? onChanged;
  final bool? enabled;
  final bool? allowUnselect;
  const MultipleAnswer({super.key, required this.child, this.value, this.onChanged, this.enabled, this.allowUnselect});
  State<MultipleAnswer<T>> createState();
}
```
