---
title: "Class: InactiveDotItem"
description: "An inactive dot item widget representing non-current positions."
---

```dart
/// An inactive dot item widget representing non-current positions.
///
/// Styled to indicate inactive items in a dot indicator with
/// optional border styling.
class InactiveDotItem extends StatelessWidget {
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
  /// Creates an inactive dot item with the specified properties.
  const InactiveDotItem({super.key, this.size, this.color, this.borderRadius, this.borderColor, this.borderWidth});
  Widget build(BuildContext context);
}
```
