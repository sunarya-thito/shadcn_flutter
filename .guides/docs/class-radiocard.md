---
title: "Class: RadioCard"
description: "Reference for RadioCard"
---

```dart
class RadioCard<T> extends StatefulWidget {
  final Widget child;
  final T value;
  final bool enabled;
  final FocusNode? focusNode;
  const RadioCard({super.key, required this.child, required this.value, this.enabled = true, this.focusNode});
  State<RadioCard<T>> createState();
}
```
