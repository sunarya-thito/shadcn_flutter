---
title: "Class: RadioTheme"
description: "Theme data for customizing [Radio] widget appearance."
---

```dart
/// Theme data for customizing [Radio] widget appearance.
///
/// This class defines the visual properties that can be applied to
/// [Radio] widgets, including colors for different states and sizing.
/// These properties can be set at the theme level to provide consistent
/// styling across the application.
///
/// The theme affects the radio button's visual appearance in both
/// selected and unselected states, including border, background,
/// and active indicator colors.
class RadioTheme {
  /// Color of the radio indicator when selected.
  final Color? activeColor;
  /// Border color of the radio button.
  final Color? borderColor;
  /// Background color of the radio button.
  final Color? backgroundColor;
  /// Size of the radio button.
  final double? size;
  /// Creates a [RadioTheme].
  ///
  /// Parameters:
  /// - [activeColor] (`Color?`, optional): Selected indicator color.
  /// - [borderColor] (`Color?`, optional): Border color.
  /// - [backgroundColor] (`Color?`, optional): Background color.
  /// - [size] (`double?`, optional): Radio button size.
  const RadioTheme({this.activeColor, this.borderColor, this.size, this.backgroundColor});
  /// Creates a copy of this theme with the given fields replaced.
  ///
  /// Parameters:
  /// - [activeColor] (`ValueGetter<Color?>?`, optional): New active color.
  /// - [borderColor] (`ValueGetter<Color?>?`, optional): New border color.
  /// - [backgroundColor] (`ValueGetter<Color?>?`, optional): New background color.
  /// - [size] (`ValueGetter<double?>?`, optional): New size.
  ///
  /// Returns: A new [RadioTheme] with updated properties.
  RadioTheme copyWith({ValueGetter<Color?>? activeColor, ValueGetter<Color?>? borderColor, ValueGetter<double?>? size, ValueGetter<Color?>? backgroundColor});
  bool operator ==(Object other);
  int get hashCode;
}
```
