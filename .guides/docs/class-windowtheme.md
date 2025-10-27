---
title: "Class: WindowTheme"
description: "Theme configuration for window components."
---

```dart
/// Theme configuration for window components.
///
/// Provides styling options for window elements including title bar height
/// and resize border thickness. Used to customize the visual appearance
/// of window components within the application.
///
/// Example:
/// ```dart
/// WindowTheme(
///   titleBarHeight: 32.0,
///   resizeThickness: 4.0,
/// )
/// ```
class WindowTheme {
  final double? titleBarHeight;
  final double? resizeThickness;
  const WindowTheme({this.titleBarHeight, this.resizeThickness});
  WindowTheme copyWith({ValueGetter<double?>? titleBarHeight, ValueGetter<double?>? resizeThickness});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
