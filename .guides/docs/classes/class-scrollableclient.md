---
title: "Class: ScrollableClient"
description: "A customizable scrollable widget with two-axis scrolling support."
---

```dart
/// A customizable scrollable widget with two-axis scrolling support.
///
/// Provides fine-grained control over scrolling behavior for both vertical
/// and horizontal axes. Supports custom scroll physics, drag behaviors,
/// and viewport-aware content building.
///
/// Example:
/// ```dart
/// ScrollableClient(
///   mainAxis: Axis.vertical,
///   verticalDetails: ScrollableDetails.vertical(),
///   builder: (context, offset, viewportSize, child) {
///     return CustomPaint(
///       painter: MyPainter(offset),
///       child: child,
///     );
///   },
///   child: MyContent(),
/// )
/// ```
class ScrollableClient extends StatelessWidget {
  /// Whether this is the primary scrollable in the widget tree.
  final bool? primary;
  /// Primary scrolling axis.
  final Axis mainAxis;
  /// Scroll configuration for vertical axis.
  final ScrollableDetails verticalDetails;
  /// Scroll configuration for horizontal axis.
  final ScrollableDetails horizontalDetails;
  /// Builder for creating content with viewport info.
  final ScrollableBuilder builder;
  /// Optional child widget.
  final Widget? child;
  /// Behavior for diagonal drag gestures.
  final DiagonalDragBehavior? diagonalDragBehavior;
  /// When drag gestures should start.
  final DragStartBehavior? dragStartBehavior;
  /// How keyboard dismissal should behave.
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;
  /// How to clip content.
  final Clip? clipBehavior;
  /// Hit test behavior.
  final HitTestBehavior? hitTestBehavior;
  /// Whether overscroll effects are enabled.
  final bool? overscroll;
  /// Creates a [ScrollableClient].
  const ScrollableClient({super.key, this.primary, this.mainAxis = Axis.vertical, this.verticalDetails = const ScrollableDetails.vertical(), this.horizontalDetails = const ScrollableDetails.horizontal(), required this.builder, this.child, this.diagonalDragBehavior, this.dragStartBehavior, this.keyboardDismissBehavior, this.clipBehavior, this.hitTestBehavior, this.overscroll});
  Widget build(BuildContext context);
}
```
