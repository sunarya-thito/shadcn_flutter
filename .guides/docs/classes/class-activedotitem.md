---
title: "Class: ActiveDotItem"
description: "An active dot item widget representing the current position."
---

```dart
/// An active dot item widget representing the current position.
///
/// Styled to highlight the currently active item in a dot indicator.
class ActiveDotItem extends StatelessWidget {
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
  /// Creates an active dot item with the specified properties.
  const ActiveDotItem({super.key, this.size, this.color, this.borderRadius, this.borderColor, this.borderWidth});
  Widget build(BuildContext context);
}
```
