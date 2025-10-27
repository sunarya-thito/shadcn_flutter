---
title: "Class: ColorPickingLayerScope"
description: "Reference for ColorPickingLayerScope"
---

```dart
abstract class ColorPickingLayerScope {
  Future<Color?> promptPickColor([ColorHistoryStorage? historyStorage]);
  static ColorPickingLayerScope findRoot(BuildContext context);
  static ColorPickingLayerScope find(BuildContext context);
}
```
