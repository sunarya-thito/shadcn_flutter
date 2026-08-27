---
title: "Class: SheetStageResolution"
description: "The context a [SheetStage] resolves against: the sheet's content [size], the  resolved edge [position], and the container's [dragHandleExtent] (main-axis  pixels occupied by the drag handle, including its gaps; 0 when there is no  handle)."
---

```dart
/// The context a [SheetStage] resolves against: the sheet's content [size], the
/// resolved edge [position], and the container's [dragHandleExtent] (main-axis
/// pixels occupied by the drag handle, including its gaps; 0 when there is no
/// handle).
class SheetStageResolution {
  /// The measured sheet content size.
  final Size size;
  /// The resolved edge position (never start/end).
  final OverlayPosition position;
  /// The main-axis extent of the drag handle (+ gaps); 0 when there is none.
  final double dragHandleExtent;
  /// Creates a resolution context.
  const SheetStageResolution({required this.size, required this.position, this.dragHandleExtent = 0});
  /// The extent of the sheet along its drag axis.
  double get axisExtent;
}
```
