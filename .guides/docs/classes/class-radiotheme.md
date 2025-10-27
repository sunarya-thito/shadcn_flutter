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
  final Color? activeColor;
  final Color? borderColor;
  final Color? backgroundColor;
  final double? size;
  const RadioTheme({this.activeColor, this.borderColor, this.size, this.backgroundColor});
  RadioTheme copyWith({ValueGetter<Color?>? activeColor, ValueGetter<Color?>? borderColor, ValueGetter<double?>? size, ValueGetter<Color?>? backgroundColor});
  bool operator ==(Object other);
  int get hashCode;
}
```
