---
title: "Class: ContextMenu"
description: "Reference for ContextMenu"
---

```dart
class ContextMenu extends StatefulWidget {
  final Widget child;
  final List<MenuItem> items;
  final HitTestBehavior behavior;
  final Axis direction;
  final bool enabled;
  const ContextMenu({super.key, required this.child, required this.items, this.behavior = HitTestBehavior.translucent, this.direction = Axis.vertical, this.enabled = true});
  State<ContextMenu> createState();
}
```
