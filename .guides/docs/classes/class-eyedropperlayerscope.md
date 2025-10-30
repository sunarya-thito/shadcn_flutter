---
title: "Class: EyeDropperLayerScope"
description: "Reference for EyeDropperLayerScope"
---

```dart
abstract class EyeDropperLayerScope {
  Future<Color?> promptPickColor([ColorHistoryStorage? historyStorage]);
  static EyeDropperLayerScope findRoot(BuildContext context);
  static EyeDropperLayerScope find(BuildContext context);
}
```
