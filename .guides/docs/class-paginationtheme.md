---
title: "Class: PaginationTheme"
description: "Theme data for customizing [Pagination] widget appearance."
---

```dart
/// Theme data for customizing [Pagination] widget appearance.
///
/// This class defines the visual and behavioral properties that can be applied to
/// [Pagination] widgets, including spacing between controls and label display
/// preferences. These properties can be set at the theme level to provide
/// consistent styling across the application.
class PaginationTheme {
  /// The spacing between pagination controls.
  final double? gap;
  /// Whether to show the previous/next labels.
  final bool? showLabel;
  /// Creates a [PaginationTheme].
  const PaginationTheme({this.gap, this.showLabel});
  /// Returns a copy of this theme with the given fields replaced.
  PaginationTheme copyWith({ValueGetter<double?>? gap, ValueGetter<bool?>? showLabel});
  bool operator ==(Object other);
  int get hashCode;
}
```
