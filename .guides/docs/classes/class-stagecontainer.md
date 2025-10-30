---
title: "Class: StageContainer"
description: "A responsive container that adapts to screen size using breakpoints."
---

```dart
/// A responsive container that adapts to screen size using breakpoints.
///
/// Constrains child width based on breakpoint strategy and adds padding.
/// Useful for creating centered, responsive layouts that adapt smoothly
/// across different screen sizes.
///
/// Example:
/// ```dart
/// StageContainer(
///   breakpoint: StageBreakpoint.defaultBreakpoints,
///   padding: EdgeInsets.symmetric(horizontal: 24),
///   builder: (context, padding) {
///     return Container(
///       padding: padding,
///       child: Text('Responsive content'),
///     );
///   },
/// )
/// ```
class StageContainer extends StatelessWidget {
  /// The breakpoint strategy for determining container width.
  ///
  /// Defaults to [StageBreakpoint.defaultBreakpoints].
  final StageBreakpoint breakpoint;
  /// Builder function that receives context and calculated padding.
  ///
  /// The padding parameter accounts for responsive adjustments.
  final Widget Function(BuildContext context, EdgeInsets padding) builder;
  /// Base padding for the container.
  ///
  /// Defaults to `EdgeInsets.symmetric(horizontal: 72)`.
  final EdgeInsets padding;
  /// Creates a [StageContainer].
  const StageContainer({super.key, this.breakpoint = StageBreakpoint.defaultBreakpoints, required this.builder, this.padding = const EdgeInsets.symmetric(horizontal: 72)});
  Widget build(BuildContext context);
}
```
