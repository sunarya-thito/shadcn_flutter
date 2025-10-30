---
title: "Class: Hidden"
description: "A widget that conditionally hides its child with optional animation."
---

```dart
/// A widget that conditionally hides its child with optional animation.
///
/// Provides a simple way to show/hide widgets with smooth animations. When
/// hidden, the widget can maintain its size in either axis or collapse
/// completely. Supports slide animations in any direction.
///
/// Example:
/// ```dart
/// Hidden(
///   hidden: !isVisible,
///   direction: Axis.vertical,
///   duration: Duration(milliseconds: 300),
///   child: Container(
///     height: 100,
///     child: Text('Toggle visibility'),
///   ),
/// )
/// ```
class Hidden extends StatelessWidget {
  /// Whether the child widget should be hidden.
  ///
  /// When `true`, the child is hidden (optionally animated). When `false`,
  /// the child is visible.
  final bool hidden;
  /// The child widget to show or hide.
  final Widget child;
  /// The axis along which to animate the hiding.
  ///
  /// If `null`, the widget is hidden without animation.
  final Axis? direction;
  /// Whether to reverse the hide animation direction.
  ///
  /// When `true`, slides out in the opposite direction.
  final bool? reverse;
  /// Duration of the hide/show animation.
  ///
  /// If `null`, uses a default duration or hides instantly.
  final Duration? duration;
  /// Animation curve for the hide/show transition.
  ///
  /// If `null`, uses a default curve.
  final Curve? curve;
  /// Whether to maintain the widget's cross-axis size when hidden.
  ///
  /// When `true`, preserves width (for vertical slides) or height (for
  /// horizontal slides) during the animation.
  final bool? keepCrossAxisSize;
  /// Whether to maintain the widget's main-axis size when hidden.
  ///
  /// When `true`, preserves the size along the animation axis, creating
  /// a fade-out effect instead of a slide.
  final bool? keepMainAxisSize;
  /// Creates a [Hidden].
  ///
  /// Parameters:
  /// - [hidden] (`bool`, required): Whether to hide the child.
  /// - [child] (`Widget`, required): Widget to show/hide.
  /// - [direction] (`Axis?`, optional): Animation axis.
  /// - [duration] (`Duration?`, optional): Animation duration.
  /// - [curve] (`Curve?`, optional): Animation curve.
  /// - [reverse] (`bool?`, optional): Reverse animation direction.
  /// - [keepCrossAxisSize] (`bool?`, optional): Maintain cross-axis size.
  /// - [keepMainAxisSize] (`bool?`, optional): Maintain main-axis size.
  const Hidden({super.key, required this.hidden, required this.child, this.direction, this.duration, this.curve, this.reverse, this.keepCrossAxisSize, this.keepMainAxisSize});
  Widget build(BuildContext context);
}
```
