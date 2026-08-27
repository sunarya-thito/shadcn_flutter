---
title: "Class: AdditiveSheetStage"
description: "Sum of two stages."
---

```dart
/// Sum of two stages.
class AdditiveSheetStage extends SheetStage {
  /// The left operand.
  final SheetStage a;
  /// The right operand.
  final SheetStage b;
  /// Creates an additive stage.
  const AdditiveSheetStage(this.a, this.b);
  double resolveDragOffset(SheetStageResolution resolution);
  double resolveBackdropTransform(SheetStageResolution resolution);
}
```
