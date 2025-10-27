---
title: "Class: WindowWidget"
description: "Reference for WindowWidget"
---

```dart
class WindowWidget extends StatefulWidget {
  final Widget? title;
  final Widget? actions;
  final Widget? content;
  final WindowController? controller;
  final bool? resizable;
  final bool? draggable;
  final bool? closable;
  final bool? maximizable;
  final bool? minimizable;
  final Rect? bounds;
  final Rect? maximized;
  final bool? minimized;
  final bool? enableSnapping;
  final BoxConstraints? constraints;
  final double? titleBarHeight;
  final double? resizeThickness;
  const WindowWidget({super.key, this.title, this.actions, this.content, this.titleBarHeight, this.resizeThickness, bool this.resizable = true, bool this.draggable = true, bool this.closable = true, bool this.maximizable = true, bool this.minimizable = true, bool this.enableSnapping = true, required Rect this.bounds, this.maximized, bool this.minimized = false, BoxConstraints this.constraints = kDefaultWindowConstraints});
  const WindowWidget.controlled({super.key, this.title, this.actions, this.content, required WindowController this.controller, this.titleBarHeight, this.resizeThickness});
  State<WindowWidget> createState();
}
```
