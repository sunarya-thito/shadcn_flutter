---
title: "Class: MediaQueryVisibilityTheme"
description: "Theme configuration for [MediaQueryVisibility]."
---

```dart
/// Theme configuration for [MediaQueryVisibility].
class MediaQueryVisibilityTheme {
  /// Minimum width at which the child is shown.
  final double? minWidth;
  /// Maximum width at which the child is shown.
  final double? maxWidth;
  /// Creates a [MediaQueryVisibilityTheme].
  const MediaQueryVisibilityTheme({this.minWidth, this.maxWidth});
  /// Creates a copy of this theme but with the given fields replaced.
  MediaQueryVisibilityTheme copyWith({ValueGetter<double?>? minWidth, ValueGetter<double?>? maxWidth});
  bool operator ==(Object other);
  int get hashCode;
}
```
