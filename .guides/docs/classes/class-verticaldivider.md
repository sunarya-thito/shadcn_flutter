---
title: "Class: VerticalDivider"
description: "A vertical line used to separate content in a layout."
---

```dart
/// A vertical line used to separate content in a layout.
///
/// Similar to [Divider] but renders vertically, useful for separating
/// content in horizontal layouts like rows or navigation panels.
class VerticalDivider extends StatelessWidget implements PreferredSizeWidget {
  /// The color of the divider line.
  final Color? color;
  /// The total width of the divider (including padding).
  final double? width;
  /// The thickness of the divider line.
  final double? thickness;
  /// The amount of empty space before the divider line starts.
  final double? indent;
  /// The amount of empty space after the divider line ends.
  final double? endIndent;
  /// Optional child widget to display alongside the divider.
  final Widget? child;
  /// Padding around the divider content.
  final EdgeInsetsGeometry? padding;
  /// Creates a vertical divider.
  const VerticalDivider({super.key, this.color, this.width, this.thickness, this.indent, this.endIndent, this.child, this.padding = const EdgeInsets.symmetric(vertical: 8)});
  Size get preferredSize;
  Widget build(BuildContext context);
}
```
