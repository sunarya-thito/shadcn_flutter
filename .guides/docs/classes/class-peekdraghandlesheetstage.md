---
title: "Class: PeekDragHandleSheetStage"
description: "A [SheetStage] that peeks only the drag handle."
---

```dart
/// A [SheetStage] that peeks only the drag handle.
class PeekDragHandleSheetStage extends SheetStage {
  /// Explicit backdrop transform for this stage; null falls back to expansion.
  final double? backdropTransform;
  /// Creates a peek-drag-handle stage.
  const PeekDragHandleSheetStage({this.backdropTransform});
  double resolveDragOffset(SheetStageResolution resolution);
  double resolveBackdropTransform(SheetStageResolution resolution);
}
```
