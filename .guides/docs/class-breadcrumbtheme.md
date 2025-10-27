---
title: "Class: BreadcrumbTheme"
description: "Theme for [Breadcrumb]."
---

```dart
/// Theme for [Breadcrumb].
class BreadcrumbTheme {
  /// Separator widget between breadcrumb items.
  final Widget? separator;
  /// Padding around the breadcrumb row.
  final EdgeInsetsGeometry? padding;
  /// Creates a [BreadcrumbTheme].
  const BreadcrumbTheme({this.separator, this.padding});
  /// Returns a copy of this theme with the given fields replaced.
  BreadcrumbTheme copyWith({ValueGetter<Widget?>? separator, ValueGetter<EdgeInsetsGeometry?>? padding});
  bool operator ==(Object other);
  int get hashCode;
}
```
