---
title: "Class: SurfaceBarrierPainter"
description: "Custom painter that creates a barrier effect with an optional cutout."
---

```dart
/// Custom painter that creates a barrier effect with an optional cutout.
///
/// Paints a large colored rectangle that covers the entire screen, with
/// an optional rounded rectangle cutout to create a "spotlight" effect
/// around modal content. Uses path clipping to create the cutout area.
///
/// Features:
/// - Full-screen barrier painting
/// - Rounded rectangle cutouts
/// - Configurable colors and padding
/// - Efficient repainting optimization
///
/// Example:
/// ```dart
/// CustomPaint(
///   painter: SurfaceBarrierPainter(
///     clip: true,
///     borderRadius: BorderRadius.circular(8),
///     barrierColor: Colors.black54,
///     padding: EdgeInsets.all(16),
///   ),
/// )
/// ```
class SurfaceBarrierPainter extends CustomPainter {
  /// Large size constant for creating screen-filling effects.
  static const double bigSize = 1000000;
  /// Large screen size for painting operations.
  static const bigScreen = Size(bigSize, bigSize);
  /// Large offset to center the big screen.
  static const bigOffset = Offset(-bigSize / 2, -bigSize / 2);
  /// Whether to clip a cutout area in the barrier.
  final bool clip;
  /// Border radius for the cutout area.
  final BorderRadius borderRadius;
  /// Color of the barrier.
  final Color barrierColor;
  /// Padding around the cutout area.
  final EdgeInsets padding;
  /// Creates a [SurfaceBarrierPainter].
  ///
  /// Parameters:
  /// - [clip] (bool, required): whether to create a cutout in the barrier
  /// - [borderRadius] (BorderRadius, required): radius for the cutout corners
  /// - [barrierColor] (Color, required): color of the barrier
  /// - [padding] (EdgeInsets, default: EdgeInsets.zero): padding around cutout
  ///
  /// Example:
  /// ```dart
  /// SurfaceBarrierPainter(
  ///   clip: true,
  ///   borderRadius: BorderRadius.circular(12),
  ///   barrierColor: Colors.black54,
  /// )
  /// ```
  SurfaceBarrierPainter({required this.clip, required this.borderRadius, required this.barrierColor, this.padding = EdgeInsets.zero});
  void paint(Canvas canvas, Size size);
  bool shouldRepaint(covariant SurfaceBarrierPainter oldDelegate);
}
```
