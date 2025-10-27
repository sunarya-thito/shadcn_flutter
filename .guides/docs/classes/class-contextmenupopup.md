---
title: "Class: ContextMenuPopup"
description: "Reference for ContextMenuPopup"
---

```dart
class ContextMenuPopup extends StatelessWidget {
  final BuildContext anchorContext;
  final Offset position;
  final List<MenuItem> children;
  final CapturedThemes? themes;
  final Axis direction;
  final ValueChanged<PopoverOverlayWidgetState>? onTickFollow;
  final Size? anchorSize;
  const ContextMenuPopup({super.key, required this.anchorContext, required this.position, required this.children, this.themes, this.direction = Axis.vertical, this.onTickFollow, this.anchorSize});
  Widget build(BuildContext context);
}
```
