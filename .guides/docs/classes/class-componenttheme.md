---
title: "Class: ComponentTheme"
description: "Reference for ComponentTheme"
---

```dart
class ComponentTheme<T> extends InheritedTheme {
  final T data;
  const ComponentTheme({super.key, required this.data, required super.child});
  Widget wrap(BuildContext context, Widget child);
  static T of<T>(BuildContext context);
  static T? maybeOf<T>(BuildContext context);
  bool updateShouldNotify(covariant ComponentTheme<T> oldWidget);
}
```
