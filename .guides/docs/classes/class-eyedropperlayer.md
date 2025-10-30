---
title: "Class: EyeDropperLayer"
description: "A layer widget that provides eye dropper (color picking) functionality."
---

```dart
/// A layer widget that provides eye dropper (color picking) functionality.
///
/// [EyeDropperLayer] wraps its child widget and enables screen color sampling.
/// When active, it displays a magnified preview of the area under the cursor
/// and allows users to pick colors directly from the screen.
///
/// Features:
/// - Magnified preview of screen area
/// - Customizable preview size and scale
/// - Optional color label display
/// - Flexible preview positioning
///
/// Example:
/// ```dart
/// EyeDropperLayer(
///   child: MyApp(),
///   showPreview: true,
///   previewScale: 10,
///   previewLabelBuilder: (context, color) {
///     return Text('Color: ${colorToHex(color)}');
///   },
/// )
/// ```
class EyeDropperLayer extends StatefulWidget {
  /// The child widget to wrap.
  final Widget child;
  /// Alignment of the preview overlay.
  final AlignmentGeometry? previewAlignment;
  /// Whether to show the magnified preview.
  final bool showPreview;
  /// Size of the preview overlay.
  final Size? previewSize;
  /// Magnification scale of the preview.
  final double previewScale;
  /// Builder for custom preview label widgets.
  final PreviewLabelBuilder? previewLabelBuilder;
  /// Creates an [EyeDropperLayer].
  const EyeDropperLayer({super.key, required this.child, this.previewAlignment, this.showPreview = true, this.previewSize, this.previewScale = 8, this.previewLabelBuilder});
  State<EyeDropperLayer> createState();
}
```
