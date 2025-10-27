---
title: "Class: ColorPickingResult"
description: "Reference for ColorPickingResult"
---

```dart
class ColorPickingResult {
  final Size size;
  final List<Color> colors;
  final Color pickedColor;
  const ColorPickingResult(this.colors, this.size, this.pickedColor);
  Color operator [](Offset position);
}
```
