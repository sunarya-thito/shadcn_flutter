---
title: "Class: Theme"
description: "Reference for Theme"
---

```dart
class Theme extends InheritedTheme {
  final ThemeData data;
  const Theme({super.key, required this.data, required super.child});
  static ThemeData of(BuildContext context);
  bool updateShouldNotify(covariant Theme oldWidget);
  Widget wrap(BuildContext context, Widget child);
  void debugFillProperties(DiagnosticPropertiesBuilder properties);
}
```
