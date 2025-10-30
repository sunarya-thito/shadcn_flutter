---
title: "Class: AnimatedTheme"
description: "A widget that animates theme changes over time."
---

```dart
/// A widget that animates theme changes over time.
class AnimatedTheme extends ImplicitlyAnimatedWidget {
  /// The target theme data to animate to.
  final ThemeData data;
  /// The widget below this widget in the tree.
  final Widget child;
  /// Creates an [AnimatedTheme].
  ///
  /// Parameters:
  /// - [data] (`ThemeData`, required): Target theme.
  /// - [duration] (`Duration`, required): Animation duration.
  /// - [curve] (`Curve`, optional): Animation curve.
  /// - [child] (`Widget`, required): Child widget.
  const AnimatedTheme({super.key, required this.data, required super.duration, super.curve, required this.child});
  AnimatedWidgetBaseState<AnimatedTheme> createState();
}
```
