---
title: "Class: MediaQueryVisibility"
description: "A widget that conditionally displays children based on media query constraints."
---

```dart
/// A widget that conditionally displays children based on media query constraints.
///
/// Shows [child] when the current screen width falls within the specified range
/// defined by [minWidth] and [maxWidth]. Optionally displays [alternateChild]
/// when the width is outside the range. Useful for responsive layouts.
///
/// Example:
/// ```dart
/// MediaQueryVisibility(
///   minWidth: 600,
///   maxWidth: 1200,
///   child: TabletLayout(),
///   alternateChild: MobileLayout(),
/// )
/// ```
class MediaQueryVisibility extends StatelessWidget {
  /// Minimum screen width to show [child].
  ///
  /// If `null`, no minimum constraint is applied.
  final double? minWidth;
  /// Maximum screen width to show [child].
  ///
  /// If `null`, no maximum constraint is applied.
  final double? maxWidth;
  /// Widget to display when width is within range.
  final Widget child;
  /// Widget to display when width is outside range.
  ///
  /// If `null`, nothing is displayed when outside range.
  final Widget? alternateChild;
  /// Creates a [MediaQueryVisibility].
  ///
  /// Parameters:
  /// - [minWidth] (`double?`, optional): Minimum width threshold.
  /// - [maxWidth] (`double?`, optional): Maximum width threshold.
  /// - [child] (`Widget`, required): Widget to show within range.
  /// - [alternateChild] (`Widget?`, optional): Widget to show outside range.
  const MediaQueryVisibility({super.key, this.minWidth, this.maxWidth, required this.child, this.alternateChild});
  Widget build(BuildContext context);
}
```
