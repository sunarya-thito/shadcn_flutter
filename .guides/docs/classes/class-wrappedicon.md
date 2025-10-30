---
title: "Class: WrappedIcon"
description: "Reference for WrappedIcon"
---

```dart
class WrappedIcon extends StatelessWidget {
  final WrappedIconDataBuilder<IconThemeData> data;
  final Widget child;
  const WrappedIcon({super.key, required this.data, required this.child});
  Widget call();
  Widget build(BuildContext context);
  WrappedIcon copyWith({WrappedIconDataBuilder<IconThemeData>? data});
}
```
