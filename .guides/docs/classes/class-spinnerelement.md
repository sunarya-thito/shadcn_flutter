---
title: "Class: SpinnerElement"
description: "Base interface for spinner visual elements."
---

```dart
/// Base interface for spinner visual elements.
///
/// Implementations define how to paint individual spinner components like
/// dots, lines, or arcs onto the canvas.
abstract class SpinnerElement {
  /// Paints this spinner element onto the canvas.
  ///
  /// Parameters:
  /// - [canvas]: The canvas to paint on
  /// - [size]: The size of the spinner widget
  /// - [transform]: The current transformation matrix for animation
  void paint(Canvas canvas, Size size, Matrix4 transform);
}
```
