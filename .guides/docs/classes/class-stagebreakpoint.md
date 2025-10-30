---
title: "Class: StageBreakpoint"
description: "Abstract base class for defining stage-based layout breakpoints."
---

```dart
/// Abstract base class for defining stage-based layout breakpoints.
///
/// Provides strategies for determining minimum and maximum widths based on
/// container size. Used by [StageContainer] to create responsive layouts
/// that adapt to screen size in discrete steps.
abstract class StageBreakpoint {
  /// Creates a constant breakpoint with uniform stepping.
  ///
  /// Parameters:
  /// - [breakpoint] (`double`, required): Step size for width calculations.
  /// - [minSize] (`double`, default: `0`): Minimum allowed size.
  /// - [maxSize] (`double`, default: `double.infinity`): Maximum allowed size.
  factory StageBreakpoint.constant(double breakpoint, {double minSize = 0, double maxSize = double.infinity});
  /// Creates staged breakpoints from a list of specific width values.
  ///
  /// Parameters:
  /// - [breakpoints] (`List<double>`, required): List of breakpoint widths.
  factory StageBreakpoint.staged(List<double> breakpoints);
  /// Default responsive breakpoints (576, 768, 992, 1200, 1400).
  ///
  /// Matches common responsive design breakpoints for mobile, tablet, desktop.
  static const StageBreakpoint defaultBreakpoints = StagedBreakpoint.defaultBreakpoints();
  /// Calculates the minimum width for the given container [width].
  double getMinWidth(double width);
  /// Calculates the maximum width for the given container [width].
  double getMaxWidth(double width);
  /// Minimum allowed size constraint.
  double get minSize;
  /// Maximum allowed size constraint.
  double get maxSize;
}
```
