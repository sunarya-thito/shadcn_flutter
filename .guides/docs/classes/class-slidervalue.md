---
title: "Class: SliderValue"
description: "Represents a slider value, supporting both single and range configurations."
---

```dart
/// Represents a slider value, supporting both single and range configurations.
///
/// A [SliderValue] can represent either a single point value or a dual-thumb
/// range with start and end values. Use [SliderValue.single] for single-thumb
/// sliders and [SliderValue.ranged] for range sliders.
///
/// This class provides value interpolation, division rounding, and comparison
/// operations needed for slider animations and discrete value snapping.
///
/// Example:
/// ```dart
/// // Single value slider
/// final single = SliderValue.single(0.5);
/// print(single.value); // 0.5
///
/// // Range slider
/// final range = SliderValue.ranged(0.2, 0.8);
/// print(range.start); // 0.2
/// print(range.end);   // 0.8
/// ```
class SliderValue {
  /// Linearly interpolates between two [SliderValue] objects.
  ///
  /// Returns `null` if either [a] or [b] is `null`, or if the values have
  /// mismatched types (one single, one ranged). Otherwise, interpolates between
  /// the values using the interpolation factor [t] (typically 0.0 to 1.0).
  ///
  /// Parameters:
  /// - [a] (`SliderValue?`, optional): Start value for interpolation.
  /// - [b] (`SliderValue?`, optional): End value for interpolation.
  /// - [t] (`double`, required): Interpolation factor, where 0.0 returns [a]
  ///   and 1.0 returns [b].
  ///
  /// Returns: `SliderValue?` — interpolated value, or `null` if incompatible.
  static SliderValue? lerp(SliderValue? a, SliderValue? b, double t);
  /// Creates a single-value [SliderValue] with the specified [value].
  ///
  /// Use this constructor for standard single-thumb sliders. The slider will
  /// have one draggable thumb and a clickable track.
  ///
  /// Parameters:
  /// - [value] (`double`, required): The slider value position.
  ///
  /// Example:
  /// ```dart
  /// final slider = SliderValue.single(0.75);
  /// ```
  const SliderValue.single(double value);
  /// Creates a range [SliderValue] with start and end positions.
  ///
  /// Use this constructor for dual-thumb range sliders. The slider will have
  /// two draggable thumbs but a non-clickable track.
  ///
  /// Parameters:
  /// - [_start] (`double`, required): The start position of the range.
  /// - [_end] (`double`, required): The end position of the range.
  ///
  /// Example:
  /// ```dart
  /// final range = SliderValue.ranged(0.2, 0.8);
  /// ```
  const SliderValue.ranged(double this._start, this._end);
  /// Whether this is a range slider value (dual-thumb).
  ///
  /// Returns `true` if created with [SliderValue.ranged], `false` if created
  /// with [SliderValue.single].
  bool get isRanged;
  /// The start position of the slider value.
  ///
  /// For ranged sliders, returns the actual start position. For single-value
  /// sliders, returns the same as [value].
  double get start;
  /// The end position of the slider value.
  ///
  /// For ranged sliders, returns the end position. For single-value sliders,
  /// returns the same as [value].
  double get end;
  /// The value position for single-value sliders.
  ///
  /// Always returns the end position. For single-value sliders, this is the
  /// primary value. For ranged sliders, this returns the end of the range.
  double get value;
  bool operator ==(Object other);
  int get hashCode;
  /// Rounds the slider value to discrete divisions.
  ///
  /// Snaps the value(s) to the nearest division point based on the specified
  /// number of [divisions]. Useful for creating discrete stepped sliders.
  ///
  /// Parameters:
  /// - [divisions] (`int`, required): Number of discrete steps.
  ///
  /// Returns: `SliderValue` — rounded value.
  ///
  /// Example:
  /// ```dart
  /// final value = SliderValue.single(0.333);
  /// final rounded = value.roundToDivisions(10);
  /// // Results in SliderValue.single(0.3)
  /// ```
  SliderValue roundToDivisions(int divisions);
}
```
