---
title: "Class: HSVColorSlider"
description: "A slider widget for adjusting HSV color components."
---

```dart
/// A slider widget for adjusting HSV color components.
///
/// [HSVColorSlider] provides an interactive slider for modifying different
/// aspects of an HSV color (hue, saturation, value, and combinations).
/// The slider displays a gradient representing the selected color channel(s)
/// and allows users to drag to adjust values.
///
/// Example:
/// ```dart
/// HSVColorSlider(
///   value: HSVColor.fromColor(Colors.blue),
///   sliderType: HSVColorSliderType.hue,
///   onChanged: (newColor) {
///     print('New hue: ${newColor.hue}');
///   },
/// )
/// ```
class HSVColorSlider extends StatefulWidget {
  /// The current HSV color value.
  final HSVColor value;
  /// Called while the slider is being dragged.
  final ValueChanged<HSVColor>? onChanging;
  /// Called when the slider interaction is complete.
  final ValueChanged<HSVColor>? onChanged;
  /// The type of HSV component(s) this slider controls.
  final HSVColorSliderType sliderType;
  /// Whether to reverse the slider direction.
  final bool reverse;
  /// Corner radius for the slider.
  final Radius radius;
  /// Padding around the slider.
  final EdgeInsets padding;
  /// Creates an [HSVColorSlider].
  const HSVColorSlider({super.key, required this.value, this.onChanging, this.onChanged, required this.sliderType, this.reverse = false, this.radius = const Radius.circular(0), this.padding = const EdgeInsets.all(0)});
  State<HSVColorSlider> createState();
}
```
