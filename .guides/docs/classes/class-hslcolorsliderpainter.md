---
title: "Class: HSLColorSliderPainter"
description: "A custom painter for rendering HSL color slider gradients."
---

```dart
/// A custom painter for rendering HSL color slider gradients.
///
/// [HSLColorSliderPainter] draws the gradient background for HSL color sliders,
/// showing the range of possible colors for the selected slider type. The
/// gradient updates based on the current color and slider configuration.
class HSLColorSliderPainter extends CustomPainter {
  /// The type of slider being painted.
  final HSLColorSliderType sliderType;
  /// The current HSL color.
  final HSLColor color;
  /// Whether the gradient direction is reversed.
  final bool reverse;
  /// Creates an [HSLColorSliderPainter].
  HSLColorSliderPainter({required this.sliderType, required this.color, this.reverse = false});
  void paint(Canvas canvas, Size size);
  bool shouldRepaint(covariant HSLColorSliderPainter oldDelegate);
}
```
