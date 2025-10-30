---
title: "Class: CalendarTheme"
description: "Theme configuration for calendar widgets."
---

```dart
/// Theme configuration for calendar widgets.
///
/// Provides styling options for calendar components, including arrow icon colors
/// for navigation buttons and other visual elements.
class CalendarTheme {
  /// Color of navigation arrow icons.
  final Color? arrowIconColor;
  /// Creates a [CalendarTheme].
  ///
  /// Parameters:
  /// - [arrowIconColor] (`Color?`, optional): Color for navigation arrow icons.
  const CalendarTheme({this.arrowIconColor});
  /// Creates a copy of this theme with the given fields replaced.
  CalendarTheme copyWith({ValueGetter<Color?>? arrowIconColor});
  bool operator ==(Object other);
  int get hashCode;
}
```
