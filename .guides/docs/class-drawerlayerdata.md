---
title: "Class: DrawerLayerData"
description: "Reference for DrawerLayerData"
---

```dart
class DrawerLayerData {
  final DrawerOverlayState overlay;
  final DrawerLayerData? parent;
  const DrawerLayerData(this.overlay, this.parent);
  Size? computeSize();
  bool operator ==(Object other);
  int get hashCode;
}
```
