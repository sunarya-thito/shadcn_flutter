---
title: "Class: MenuRadio"
description: "Reference for MenuRadio"
---

```dart
class MenuRadio<T> extends StatelessWidget {
  final T value;
  final Widget child;
  final Widget? trailing;
  final FocusNode? focusNode;
  final bool enabled;
  final bool autoClose;
  const MenuRadio({super.key, required this.value, required this.child, this.trailing, this.focusNode, this.enabled = true, this.autoClose = true});
  Widget build(BuildContext context);
}
```
