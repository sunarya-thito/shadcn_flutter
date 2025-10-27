---
title: "Class: DrawerOverlay"
description: "Reference for DrawerOverlay"
---

```dart
class DrawerOverlay extends StatefulWidget {
  final Widget child;
  const DrawerOverlay({super.key, required this.child});
  State<DrawerOverlay> createState();
  static DrawerLayerData? maybeFind(BuildContext context, [bool root = false]);
  static DrawerLayerData? maybeFindMessenger(BuildContext context, [bool root = false]);
}
```
