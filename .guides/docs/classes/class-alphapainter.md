---
title: "Class: AlphaPainter"
description: "A custom painter that draws a checkboard pattern for alpha/transparency visualization."
---

```dart
/// A custom painter that draws a checkboard pattern for alpha/transparency visualization.
///
/// [AlphaPainter] renders a two-tone checkerboard pattern typically used behind
/// semi-transparent colors to make the transparency visible. This is a common
/// pattern in color pickers and image editors.
class AlphaPainter extends CustomPainter {
  /// Primary color for the checkerboard pattern.
  static const Color checkboardPrimary = Color(0xFFE0E0E0);
  /// Secondary color for the checkerboard pattern.
  static const Color checkboardSecondary = Color(0xFFB0B0B0);
  /// Size of each checkerboard square.
  static const double checkboardSize = 8.0;
  void paint(Canvas canvas, Size size);
  bool shouldRepaint(covariant AlphaPainter oldDelegate);
}
```
