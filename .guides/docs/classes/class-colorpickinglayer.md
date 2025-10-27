---
title: "Class: ColorPickingLayer"
description: "Reference for ColorPickingLayer"
---

```dart
class ColorPickingLayer extends StatefulWidget {
  final Widget child;
  final AlignmentGeometry? previewAlignment;
  final bool showPreview;
  final Size? previewSize;
  final double previewScale;
  final PreviewLabelBuilder? previewLabelBuilder;
  const ColorPickingLayer({super.key, required this.child, this.previewAlignment, this.showPreview = true, this.previewSize, this.previewScale = 8, this.previewLabelBuilder});
  State<ColorPickingLayer> createState();
}
```
