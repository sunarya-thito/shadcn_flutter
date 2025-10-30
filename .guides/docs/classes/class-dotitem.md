---
title: "Class: DotItem"
description: "A basic dot item widget with customizable appearance."
---

```dart
/// A basic dot item widget with customizable appearance.
///
/// Used as a base component for creating custom dot indicators.
class DotItem extends StatelessWidget {
  /// The size of the dot.
  final double? size;
  /// The color of the dot.
  final Color? color;
  /// The border radius of the dot.
  final double? borderRadius;
  /// The border color of the dot.
  final Color? borderColor;
  /// The border width of the dot.
  final double? borderWidth;
  /// Creates a dot item with the specified properties.
  const DotItem({super.key, this.size, this.color, this.borderRadius, this.borderColor, this.borderWidth});
  Widget build(BuildContext context);
}
```
