---
title: "Class: SelectItemButton"
description: "Reference for SelectItemButton"
---

```dart
class SelectItemButton<T> extends StatelessWidget {
  final T value;
  final Widget child;
  final AbstractButtonStyle style;
  final bool? enabled;
  const SelectItemButton({super.key, required this.value, required this.child, this.enabled, this.style = const ButtonStyle.ghost()});
  Widget build(BuildContext context);
}
```
