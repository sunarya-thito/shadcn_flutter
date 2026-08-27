---
title: "Class: SheetStage"
description: "A snap position for a [PinnedSheet].   A stage resolves to a *visible extent* (logical pixels) along the sheet's  axis ([resolveDragOffset]) and, independently, to a *backdrop transform*  value in `0..1` ([resolveBackdropTransform]). When a stage's explicit  `backdropTransform` is null it falls back to the stage's normalized  expansion (offset / axis extent).   Stages support arithmetic so you can express derived snap points:   ```dart  SheetStage.expanded() - SheetStage.fixed(100); // 100px short of full  SheetStage.expanded() * 0.9;                    // 90% of full  SheetStage.fixed(100) + SheetStage.fraction(0.5);  ```   Built-in stages: [SheetStage.closed], [SheetStage.expanded],  [SheetStage.fixed], [SheetStage.fraction], [SheetStage.peekDragHandle]."
---

```dart
/// A snap position for a [PinnedSheet].
///
/// A stage resolves to a *visible extent* (logical pixels) along the sheet's
/// axis ([resolveDragOffset]) and, independently, to a *backdrop transform*
/// value in `0..1` ([resolveBackdropTransform]). When a stage's explicit
/// `backdropTransform` is null it falls back to the stage's normalized
/// expansion (offset / axis extent).
///
/// Stages support arithmetic so you can express derived snap points:
///
/// ```dart
/// SheetStage.expanded() - SheetStage.fixed(100); // 100px short of full
/// SheetStage.expanded() * 0.9;                    // 90% of full
/// SheetStage.fixed(100) + SheetStage.fraction(0.5);
/// ```
///
/// Built-in stages: [SheetStage.closed], [SheetStage.expanded],
/// [SheetStage.fixed], [SheetStage.fraction], [SheetStage.peekDragHandle].
abstract class SheetStage {
  /// Const constructor for subclasses.
  const SheetStage();
  /// A fully-hidden stage (offset 0).
  factory SheetStage.closed({double? backdropTransform});
  /// A fully-shown stage (offset == the full axis extent).
  factory SheetStage.expanded({double? backdropTransform});
  /// A stage pinned at a fixed number of logical pixels from the edge.
  factory SheetStage.fixed(double offset, {double? backdropTransform});
  /// A stage pinned at a [fraction] (0..1) of the sheet's axis extent.
  factory SheetStage.fraction(double fraction, {double? backdropTransform});
  /// A stage that peeks only the drag handle. For containers without a drag
  /// handle the handle extent is 0, so this behaves like [SheetStage.closed].
  factory SheetStage.peekDragHandle({double? backdropTransform});
  /// The visible extent (logical pixels) this stage resolves to.
  double resolveDragOffset(SheetStageResolution resolution);
  /// The backdrop transform value (0..1) this stage resolves to.
  double resolveBackdropTransform(SheetStageResolution resolution);
  /// Sum of two stages (offsets and backdrop transforms are added).
  SheetStage operator +(SheetStage other);
  /// Difference of two stages (offsets and backdrop transforms are subtracted).
  SheetStage operator -(SheetStage other);
  /// Scales this stage's offset and backdrop transform by [factor].
  SheetStage operator *(double factor);
  /// Divides this stage's offset and backdrop transform by [factor].
  SheetStage operator /(double factor);
  bool operator ==(Object other);
  int get hashCode;
}
```
