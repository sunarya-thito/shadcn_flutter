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
  /// Height of the window's title bar in logical pixels.
  ///
  /// Determines the vertical space allocated for the title bar which typically
  /// contains the window title, control buttons (minimize, maximize, close),
  /// and any custom action widgets.
  ///
  /// If `null`, uses the default title bar height from the theme.
  final double? titleBarHeight;
  /// Thickness of the window's resize border in logical pixels.
  ///
  /// Defines the width of the interactive area along window edges that
  /// allows users to resize the window by dragging. A larger value makes
  /// it easier to grab the edge for resizing.
  ///
  /// If `null`, uses the default resize border thickness from the theme.
  final double? resizeThickness;
  /// Creates a window theme with optional title bar and resize border settings.
  ///
  /// Both parameters are optional. When `null`, the corresponding values
  /// will fall back to theme defaults.
  const WindowTheme({this.titleBarHeight, this.resizeThickness});
  /// Creates a copy of this theme with optionally replaced values.
  ///
  /// Uses [ValueGetter] functions to allow nullable value replacement.
  /// If a parameter is `null`, the current value is retained. If provided,
  /// the getter function is called to retrieve the new value.
  ///
  /// Parameters:
  /// - [titleBarHeight]: Optional getter for new title bar height
  /// - [resizeThickness]: Optional getter for new resize thickness
  ///
  /// Returns a new [WindowTheme] instance with updated values.
  WindowTheme copyWith({ValueGetter<double?>? titleBarHeight, ValueGetter<double?>? resizeThickness});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
