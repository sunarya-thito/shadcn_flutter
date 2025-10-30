---
title: "Class: NavigationGap"
description: "Spacing gap between navigation items."
---

```dart
/// Spacing gap between navigation items.
///
/// Creates empty space in navigation bars or sidebars. Automatically
/// uses appropriate gap type based on container (Gap for boxes, SliverGap for slivers).
class NavigationGap extends StatelessWidget implements NavigationBarItem {
  /// Size of the gap in logical pixels.
  final double gap;
  /// Creates a navigation gap.
  ///
  /// Parameters:
  /// - [gap] (double, required): Gap size in logical pixels
  const NavigationGap(this.gap, {super.key});
  bool get selectable;
  /// Builds the gap widget for box-based navigation containers.
  ///
  /// Returns a [Gap] widget with the specified gap size.
  Widget buildBox(BuildContext context);
  /// Builds the gap widget for sliver-based navigation containers.
  ///
  /// Returns a [SliverGap] widget with the specified gap size.
  Widget buildSliver(BuildContext context);
  Widget build(BuildContext context);
}
```
