---
title: "Class: FractionSheetStage"
description: "A [SheetStage] pinned at a fraction of the sheet's axis extent."
---

```dart
/// A [SheetStage] pinned at a fraction of the sheet's axis extent.
class FractionSheetStage extends SheetStage {
  /// The fraction (0..1) of the axis extent.
  final double fraction;
  /// Explicit backdrop transform for this stage; null falls back to expansion.
  final double? backdropTransform;
  /// Creates a fractional stage.
  const FractionSheetStage(this.fraction, {this.backdropTransform});
  double resolveDragOffset(SheetStageResolution resolution);
  double resolveBackdropTransform(SheetStageResolution resolution);
}
```
