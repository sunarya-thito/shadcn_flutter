---
title: "Class: Spinner"
description: "Reference for Spinner"
---

```dart
abstract class Spinner extends StatelessWidget {
  final Color? color;
  final double? size;
  const Spinner({super.key, this.color, this.size});
  /// Resolve spinner color considering theme overrides.
  Color? resolveColor(BuildContext context);
  /// Resolve spinner size considering theme overrides and a default value.
  double resolveSize(BuildContext context, double defaultValue);
}
```
