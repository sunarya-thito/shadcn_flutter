---
title: "Class: DrawerEntryWidgetState"
description: "Reference for DrawerEntryWidgetState"
---

```dart
class DrawerEntryWidgetState<T> extends State<DrawerEntryWidget<T>> with SingleTickerProviderStateMixin {
  ValueNotifier<double> additionalOffset;
  void initState();
  void dispose();
  void didUpdateWidget(covariant DrawerEntryWidget<T> oldWidget);
  Future<void> close([T? result]);
  Widget build(BuildContext context);
}
```
