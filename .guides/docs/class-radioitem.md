---
title: "Class: RadioItem"
description: "Reference for RadioItem"
---

```dart
class RadioItem<T> extends StatefulWidget {
  final Widget? leading;
  final Widget? trailing;
  final T value;
  final bool enabled;
  final FocusNode? focusNode;
  const RadioItem({super.key, this.leading, this.trailing, required this.value, this.enabled = true, this.focusNode});
  State<RadioItem<T>> createState();
}
```
