---
title: "Class: SubtractedSheetStage"
description: "Difference of two stages."
---

```dart
/// Difference of two stages.
class SubtractedSheetStage extends SheetStage {
  /// The left operand.
  final SheetStage a;
  /// The right operand.
  final SheetStage b;
  /// Creates a subtracted stage.
  const SubtractedSheetStage(this.a, this.b);
  double resolveDragOffset(SheetStageResolution resolution);
  double resolveBackdropTransform(SheetStageResolution resolution);
}
```
