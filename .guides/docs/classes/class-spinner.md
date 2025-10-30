---
title: "Class: Spinner"
description: "Abstract base class for all spinner widgets."
---

```dart
/// Abstract base class for all spinner widgets.
///
/// [Spinner] provides common functionality for loading indicators including
/// color and size resolution from theme. Concrete implementations include
/// [CircularSpinner], [DotsSpinner], and others.
abstract class Spinner extends StatelessWidget {
  /// Optional color override for the spinner.
  ///
  /// If `null`, uses theme's spinner color or default foreground color.
  final Color? color;
  /// Optional size override for the spinner in logical pixels.
  ///
  /// If `null`, uses theme's spinner size or a default size.
  final double? size;
  /// Creates a [Spinner] with optional color and size overrides.
  const Spinner({super.key, this.color, this.size});
  /// Resolve spinner color considering theme overrides.
  Color? resolveColor(BuildContext context);
  /// Resolve spinner size considering theme overrides and a default value.
  double resolveSize(BuildContext context, double defaultValue);
}
```
