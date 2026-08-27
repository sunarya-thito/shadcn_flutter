---
title: "Class: ClosedSheetStage"
description: "A [SheetStage] that is fully hidden."
---

```dart
/// A [SheetStage] that is fully hidden.
class ClosedSheetStage extends SheetStage {
  /// Explicit backdrop transform for this stage; null falls back to expansion.
  final double? backdropTransform;
  /// Creates a closed stage.
  const ClosedSheetStage({this.backdropTransform});
  double resolveDragOffset(SheetStageResolution resolution);
  double resolveBackdropTransform(SheetStageResolution resolution);
}
```
