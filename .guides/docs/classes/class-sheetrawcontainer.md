---
title: "Class: SheetRawContainer"
description: "The sheet variant of [DrawerRawContainer]: no rounded corners, only a single  inner border, and safe-area handled via an outer margin."
---

```dart
/// The sheet variant of [DrawerRawContainer]: no rounded corners, only a single
/// inner border, and safe-area handled via an outer margin.
class SheetRawContainer extends DrawerRawContainer {
  /// Creates a sheet container.
  const SheetRawContainer({super.key, required super.position, required super.child, required super.size, required super.stackIndex, super.expands = true, super.draggable = false, super.showDragHandle = true, super.dragHandleSize, super.padding, super.margin, super.surfaceOpacity, super.surfaceBlur, super.barrierColor, super.gapBeforeDragger, super.gapAfterDragger, super.constraints, super.alignment, super.fadeAnimation, super.extraSize, super.overscroll, super.gestureWrapper, super.startPadding, super.endPadding, super.crossAxisSize, super.crossAxisAlignment});
  Border getBorder(ThemeData theme);
  BorderRadiusGeometry getBorderRadius(double radius);
  BoxDecoration getDecoration(ThemeData theme);
}
```
