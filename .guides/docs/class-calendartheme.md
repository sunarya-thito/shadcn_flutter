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
  const CalendarTheme({this.arrowIconColor});
  CalendarTheme copyWith({ValueGetter<Color?>? arrowIconColor});
  bool operator ==(Object other);
  int get hashCode;
}
```
