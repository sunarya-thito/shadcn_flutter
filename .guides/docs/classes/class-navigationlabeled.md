---
title: "Class: NavigationLabeled"
description: "Internal widget that handles label positioning and expansion animation."
---

```dart
/// Internal widget that handles label positioning and expansion animation.
class NavigationLabeled extends StatelessWidget {
  /// The main content widget.
  final Widget child;
  /// The label widget.
  final Widget label;
  /// Where to position the label relative to the child.
  final NavigationLabelPosition position;
  /// Spacing between label and child.
  final double spacing;
  /// Whether to show the label.
  final bool showLabel;
  /// Type of label presentation.
  final NavigationLabelType labelType;
  /// Layout direction of the navigation.
  final Axis direction;
  /// Whether to maintain cross axis size when hidden.
  final bool keepCrossAxisSize;
  /// Whether to maintain main axis size when hidden.
  final bool keepMainAxisSize;
  /// Creates a [NavigationLabeled].
  const NavigationLabeled({super.key, required this.child, required this.label, required this.spacing, required this.position, required this.showLabel, required this.labelType, required this.direction, required this.keepCrossAxisSize, required this.keepMainAxisSize});
  Widget build(BuildContext context);
}
```
