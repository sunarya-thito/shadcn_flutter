---
title: "Class: NavigationDivider"
description: "Visual divider between navigation items."
---

```dart
/// Visual divider between navigation items.
///
/// Renders a horizontal or vertical line separator in navigation bars.
/// Automatically adapts direction based on navigation orientation.
class NavigationDivider extends StatelessWidget implements NavigationBarItem {
  /// Optional thickness of the divider line.
  final double? thickness;
  /// Optional color for the divider.
  final Color? color;
  /// Creates a navigation divider.
  ///
  /// Parameters:
  /// - [thickness] (double?): Line thickness
  /// - [color] (Color?): Divider color
  const NavigationDivider({super.key, this.thickness, this.color});
  bool get selectable;
  Widget build(BuildContext context);
}
```
