---
title: "Class: DividedSheetStage"
description: "A stage divided by a scalar [factor]."
---

```dart
/// A stage divided by a scalar [factor].
class DividedSheetStage extends SheetStage {
  /// The operand.
  final SheetStage stage;
  /// The scalar divisor.
  final double factor;
  /// Creates a divided stage.
  const DividedSheetStage(this.stage, this.factor);
  double resolveDragOffset(SheetStageResolution resolution);
  double resolveBackdropTransform(SheetStageResolution resolution);
}
```
