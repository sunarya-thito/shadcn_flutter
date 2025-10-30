---
title: "Class: EyeDropperLayer"
description: "Reference for EyeDropperLayer"
---

```dart
class EyeDropperLayer extends StatefulWidget {
  final Widget child;
  final AlignmentGeometry? previewAlignment;
  final bool showPreview;
  final Size? previewSize;
  final double previewScale;
  final PreviewLabelBuilder? previewLabelBuilder;
  const EyeDropperLayer({super.key, required this.child, this.previewAlignment, this.showPreview = true, this.previewSize, this.previewScale = 8, this.previewLabelBuilder});
  State<EyeDropperLayer> createState();
}
```
