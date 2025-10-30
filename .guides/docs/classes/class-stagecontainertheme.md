---
title: "Class: StageContainerTheme"
description: "Theme configuration for [StageContainer] responsive behavior."
---

```dart
/// Theme configuration for [StageContainer] responsive behavior.
///
/// Defines default breakpoint strategy and padding for stage containers.
class StageContainerTheme {
  /// The breakpoint strategy to use.
  final StageBreakpoint? breakpoint;
  /// Default padding for the container.
  final EdgeInsets? padding;
  /// Creates a [StageContainerTheme].
  const StageContainerTheme({this.breakpoint, this.padding});
  /// Creates a copy of this theme with the given fields replaced.
  StageContainerTheme copyWith({ValueGetter<StageBreakpoint?>? breakpoint, ValueGetter<EdgeInsets?>? padding});
  bool operator ==(Object other);
  int get hashCode;
}
```
