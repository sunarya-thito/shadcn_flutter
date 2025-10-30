---
title: "Class: HSLColorSlider"
description: "A slider widget for adjusting HSL color components."
---

```dart
/// A slider widget for adjusting HSL color components.
///
/// [HSLColorSlider] provides an interactive slider for modifying different
/// aspects of an HSL color (hue, saturation, lightness, and combinations).
/// The slider displays a gradient representing the selected color channel(s)
/// and allows users to drag to adjust values.
///
/// Example:
/// ```dart
/// HSLColorSlider(
///   color: HSLColor.fromColor(Colors.blue),
///   sliderType: HSLColorSliderType.hue,
///   onChanged: (newColor) {
///     print('New hue: ${newColor.hue}');
///   },
/// )
/// ```
class HSLColorSlider extends StatefulWidget {
  /// The current HSL color value.
  final HSLColor color;
  /// Called while the slider is being dragged.
  final ValueChanged<HSLColor>? onChanging;
  /// Called when the slider interaction is complete.
  final ValueChanged<HSLColor>? onChanged;
  /// The type of HSL component(s) this slider controls.
  final HSLColorSliderType sliderType;
  /// Whether to reverse the slider direction.
  final bool reverse;
  /// Corner radius for the slider.
  final Radius radius;
  /// Padding around the slider.
  final EdgeInsets padding;
  /// Creates an [HSLColorSlider].
  const HSLColorSlider({super.key, required this.color, this.onChanging, this.onChanged, required this.sliderType, this.reverse = false, this.radius = const Radius.circular(0), this.padding = const EdgeInsets.all(0)});
  State<HSLColorSlider> createState();
}
```
