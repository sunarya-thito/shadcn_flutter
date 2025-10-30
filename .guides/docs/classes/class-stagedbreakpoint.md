---
title: "Class: StagedBreakpoint"
description: "A breakpoint that uses predefined stage values."
---

```dart
/// A breakpoint that uses predefined stage values.
///
/// Maps container widths to the nearest breakpoint value from a list.
/// Commonly used for responsive design with specific breakpoints like
/// mobile (576), tablet (768), desktop (992), etc.
class StagedBreakpoint implements StageBreakpoint {
  /// List of breakpoint width values in ascending order.
  final List<double> breakpoints;
  /// Creates a [StagedBreakpoint] with custom breakpoints.
  ///
  /// Requires at least 2 breakpoints.
  const StagedBreakpoint(this.breakpoints);
  /// Creates a [StagedBreakpoint] with default responsive breakpoints.
  const StagedBreakpoint.defaultBreakpoints();
  double getMinWidth(double width);
  double getMaxWidth(double width);
  double get minSize;
  double get maxSize;
}
```
