---
title: "Class: EyeDropperResult"
description: "Reference for EyeDropperResult"
---

```dart
class EyeDropperResult {
  final Size size;
  final List<Color> colors;
  final Color pickedColor;
  const EyeDropperResult(this.colors, this.size, this.pickedColor);
  Color operator [](Offset position);
}
```
