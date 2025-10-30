---
title: "Class: SurfaceBlur"
description: "A widget that applies a blur effect to its background."
---

```dart
/// A widget that applies a blur effect to its background.
///
/// Creates a frosted glass or translucent blur effect behind the child widget
/// using a backdrop filter. The blur amount is controlled by [surfaceBlur].
///
/// Example:
/// ```dart
/// SurfaceBlur(
///   surfaceBlur: 10,
///   borderRadius: BorderRadius.circular(8),
///   child: Container(
///     color: Colors.white.withOpacity(0.5),
///     child: Text('Blurred background'),
///   ),
/// )
/// ```
class SurfaceBlur extends StatefulWidget {
  /// The child widget to display with blurred background.
  final Widget child;
  /// The amount of blur to apply (sigma value for blur filter).
  ///
  /// If `null` or `<= 0`, no blur is applied.
  final double? surfaceBlur;
  /// Border radius for clipping the blur effect.
  ///
  /// If `null`, no rounding is applied.
  final BorderRadiusGeometry? borderRadius;
  /// Creates a [SurfaceBlur].
  const SurfaceBlur({super.key, required this.child, this.surfaceBlur, this.borderRadius});
  State<SurfaceBlur> createState();
}
```
