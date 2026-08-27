---
title: "Class: FixedSheetStage"
description: "A [SheetStage] pinned at a fixed number of logical pixels."
---

```dart
/// A [SheetStage] pinned at a fixed number of logical pixels.
class FixedSheetStage extends SheetStage {
  /// The pixel offset from the closed edge.
  final double offset;
  /// Explicit backdrop transform for this stage; null falls back to expansion.
  final double? backdropTransform;
  /// Creates a fixed-offset stage.
  const FixedSheetStage(this.offset, {this.backdropTransform});
  double resolveDragOffset(SheetStageResolution resolution);
  double resolveBackdropTransform(SheetStageResolution resolution);
}
```
