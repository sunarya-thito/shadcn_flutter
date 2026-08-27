---
title: "Class: ExpandedSheetStage"
description: "A [SheetStage] that is fully expanded."
---

```dart
/// A [SheetStage] that is fully expanded.
class ExpandedSheetStage extends SheetStage {
  /// Explicit backdrop transform for this stage; null falls back to expansion.
  final double? backdropTransform;
  /// Creates an expanded stage.
  const ExpandedSheetStage({this.backdropTransform});
  double resolveDragOffset(SheetStageResolution resolution);
  double resolveBackdropTransform(SheetStageResolution resolution);
}
```
