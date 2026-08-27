---
title: "Class: SliderValueIndicator"
description: "Default bubble widget for displaying a [Slider]'s current value.   Pass this (or a widget wrapping it) as [Slider.valueIndicatorBuilder] (or  [SliderTheme.valueIndicatorBuilder]) to opt into showing a small  tooltip-styled bubble above the thumb while dragging or focused:   ```dart  Slider(    value: value,    onChanged: (v) => setState(() => value = v),    valueIndicatorBuilder: (context, value) => SliderValueIndicator(value: value),  )  ```"
---

```dart
/// Default bubble widget for displaying a [Slider]'s current value.
///
/// Pass this (or a widget wrapping it) as [Slider.valueIndicatorBuilder] (or
/// [SliderTheme.valueIndicatorBuilder]) to opt into showing a small
/// tooltip-styled bubble above the thumb while dragging or focused:
///
/// ```dart
/// Slider(
///   value: value,
///   onChanged: (v) => setState(() => value = v),
///   valueIndicatorBuilder: (context, value) => SliderValueIndicator(value: value),
/// )
/// ```
class SliderValueIndicator extends StatelessWidget {
  /// The resolved slider value to display.
  final double value;
  /// Optional custom formatter. Defaults to showing whole numbers without a
  /// decimal point and other values with up to 2 decimal places.
  final String Function(double value)? formatter;
  /// Creates a [SliderValueIndicator].
  const SliderValueIndicator({super.key, required this.value, this.formatter});
  Widget build(BuildContext context);
}
```
