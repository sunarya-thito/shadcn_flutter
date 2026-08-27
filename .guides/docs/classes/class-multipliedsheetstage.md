---
title: "Class: MultipliedSheetStage"
description: "A stage scaled by a scalar [factor]."
---

```dart
/// A stage scaled by a scalar [factor].
class MultipliedSheetStage extends SheetStage {
  /// The operand.
  final SheetStage stage;
  /// The scalar factor.
  final double factor;
  /// Creates a multiplied stage.
  const MultipliedSheetStage(this.stage, this.factor);
  double resolveDragOffset(SheetStageResolution resolution);
  double resolveBackdropTransform(SheetStageResolution resolution);
}
```
