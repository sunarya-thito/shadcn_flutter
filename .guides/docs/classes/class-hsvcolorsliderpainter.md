---
title: "Class: HSVColorSliderPainter"
description: "A custom painter for rendering HSV color slider gradients."
---

```dart
/// A custom painter for rendering HSV color slider gradients.
///
/// [HSVColorSliderPainter] draws the gradient background for HSV color sliders,
/// showing the range of possible colors for the selected slider type. The
/// gradient updates based on the current color and slider configuration.
class HSVColorSliderPainter extends CustomPainter {
  /// The type of slider being painted.
  final HSVColorSliderType sliderType;
  /// The current HSV color.
  final HSVColor color;
  /// Whether the gradient direction is reversed.
  final bool reverse;
  /// Creates an [HSVColorSliderPainter].
  HSVColorSliderPainter({required this.sliderType, required this.color, this.reverse = false});
  void paint(Canvas canvas, Size size);
  bool shouldRepaint(covariant HSVColorSliderPainter oldDelegate);
}
```
