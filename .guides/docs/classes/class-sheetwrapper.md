---
title: "Class: SheetWrapper"
description: "Wrapper widget for sheet overlays."
---

```dart
/// Wrapper widget for sheet overlays.
///
/// Extends [DrawerWrapper] with sheet-specific defaults (no drag, no expansion).
/// Sheets are simplified drawers without backdrop transformation.
class SheetWrapper extends DrawerWrapper {
  /// Creates a [SheetWrapper].
  const SheetWrapper({super.key, required super.position, required super.child, required super.size, required super.stackIndex, super.draggable = false, super.expands = false, super.extraSize = Size.zero, super.padding, super.surfaceBlur, super.surfaceOpacity, super.barrierColor, super.gapBeforeDragger, super.gapAfterDragger, super.constraints, super.alignment});
  State<DrawerWrapper> createState();
}
```
