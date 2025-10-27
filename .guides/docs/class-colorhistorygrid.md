---
title: "Class: ColorHistoryGrid"
description: "Reference for ColorHistoryGrid"
---

```dart
class ColorHistoryGrid extends StatelessWidget {
  final ColorHistoryStorage storage;
  final ValueChanged<Color>? onColorPicked;
  final double? spacing;
  final int crossAxisCount;
  final Color? selectedColor;
  const ColorHistoryGrid({super.key, required this.storage, this.onColorPicked, this.spacing, this.crossAxisCount = 10, this.selectedColor});
  Widget build(BuildContext context);
}
```
