---
title: "Class: RenderOverflowDecoratedBox"
description: "The [RenderObject] for [OverflowDecoratedBox]."
---

```dart
/// The [RenderObject] for [OverflowDecoratedBox].
class RenderOverflowDecoratedBox extends RenderProxyBox {
  /// Creates a [RenderOverflowDecoratedBox].
  RenderOverflowDecoratedBox({required Decoration decoration, DecorationPosition position = DecorationPosition.background, ImageConfiguration configuration = ImageConfiguration.empty, RenderBox? child, EdgeInsets expands = EdgeInsets.zero});
  /// The amount by which the decoration should expand beyond the layout bounds.
  EdgeInsets get expands;
  set expands(EdgeInsets value);
  /// The decoration to paint.
  Decoration get decoration;
  set decoration(Decoration value);
  /// Whether the decoration should be painted in the background or foreground.
  DecorationPosition get position;
  set position(DecorationPosition value);
  /// The image configuration for the decoration.
  ImageConfiguration get configuration;
  set configuration(ImageConfiguration value);
  void detach();
  void dispose();
  bool hitTestSelf(Offset position);
  void paint(PaintingContext context, Offset offset);
  void debugFillProperties(DiagnosticPropertiesBuilder properties);
}
```
