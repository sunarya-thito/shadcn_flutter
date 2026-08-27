---
title: "Class: SliderTheme"
description: "Theme for [Slider]."
---

```dart
/// Theme for [Slider].
class SliderTheme extends ComponentThemeData {
  /// Height of the track.
  final double? trackHeight;
  /// Color of the inactive track.
  final Color? trackColor;
  /// Color of the active portion of the track.
  final Color? valueColor;
  /// Color of the inactive track when disabled.
  final Color? disabledTrackColor;
  /// Color of the active track when disabled.
  final Color? disabledValueColor;
  /// Background color of the thumb.
  final Color? thumbColor;
  /// Border color of the thumb.
  final Color? thumbBorderColor;
  /// Border color of the thumb when focused.
  final Color? thumbFocusedBorderColor;
  /// Size of the thumb.
  final double? thumbSize;
  /// Theme-level default for [Slider.valueIndicatorBuilder]. If both this and
  /// the widget-level builder are null, no value indicator is shown.
  final SliderValueIndicatorBuilder? valueIndicatorBuilder;
  /// Creates a [SliderTheme].
  const SliderTheme({this.trackHeight, this.trackColor, this.valueColor, this.disabledTrackColor, this.disabledValueColor, this.thumbColor, this.thumbBorderColor, this.thumbFocusedBorderColor, this.thumbSize, this.valueIndicatorBuilder});
  /// Returns a copy of this theme with the given fields replaced.
  SliderTheme copyWith({ValueGetter<double?>? trackHeight, ValueGetter<Color?>? trackColor, ValueGetter<Color?>? valueColor, ValueGetter<Color?>? disabledTrackColor, ValueGetter<Color?>? disabledValueColor, ValueGetter<Color?>? thumbColor, ValueGetter<Color?>? thumbBorderColor, ValueGetter<Color?>? thumbFocusedBorderColor, ValueGetter<double?>? thumbSize, ValueGetter<SliderValueIndicatorBuilder?>? valueIndicatorBuilder});
  bool operator ==(Object other);
  int get hashCode;
}
```
