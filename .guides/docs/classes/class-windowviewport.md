---
title: "Class: WindowViewport"
description: "Reference for WindowViewport"
---

```dart
class WindowViewport {
  final Size size;
  final WindowNavigatorHandle navigator;
  final bool focused;
  final bool alwaysOnTop;
  final bool closed;
  final bool minify;
  final bool ignorePointer;
  const WindowViewport({required this.size, required this.navigator, required this.focused, required this.alwaysOnTop, required this.closed, required this.minify, required this.ignorePointer});
  bool operator ==(Object other);
  int get hashCode;
}
```
