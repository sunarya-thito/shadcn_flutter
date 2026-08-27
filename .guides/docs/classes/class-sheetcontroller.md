---
title: "Class: SheetController"
description: "Controls a [PinnedSheet]: reads its current position and drives it to a  [SheetStage].   The controller is a [ChangeNotifier] that notifies whenever the sheet's  position changes. [stage] returns a live stage that can be compared against  derived stages:   ```dart  final controller = SheetController();  ...  PinnedSheet(controller: controller, child: ...);  ...  controller.stage = SheetStage.expanded();  controller.animateTo(SheetStage.fixed(120),      duration: kDefaultDuration, curve: Curves.easeOut);  if (controller.stage == (SheetStage.expanded() - SheetStage.fixed(100))) { ... }  ```"
---

```dart
/// Controls a [PinnedSheet]: reads its current position and drives it to a
/// [SheetStage].
///
/// The controller is a [ChangeNotifier] that notifies whenever the sheet's
/// position changes. [stage] returns a live stage that can be compared against
/// derived stages:
///
/// ```dart
/// final controller = SheetController();
/// ...
/// PinnedSheet(controller: controller, child: ...);
/// ...
/// controller.stage = SheetStage.expanded();
/// controller.animateTo(SheetStage.fixed(120),
///     duration: kDefaultDuration, curve: Curves.easeOut);
/// if (controller.stage == (SheetStage.expanded() - SheetStage.fixed(100))) { ... }
/// ```
class SheetController extends ChangeNotifier {
  /// Whether this controller is attached to a live [PinnedSheet].
  bool get isAttached;
  /// The current visible extent of the sheet, in logical pixels.
  double get offset;
  /// The current visible extent of the sheet, as a fraction (0..1) of its axis.
  double get fraction;
  /// Whether the sheet is showing at all.
  bool get isOpen;
  /// The current position as a live stage that can be compared against other
  /// (possibly derived) stages using `==`.
  SheetStage get stage;
  /// Assigning a stage animates the sheet to it with the default duration/curve.
  set stage(SheetStage stage);
  /// Animates the sheet to [stage].
  Future<void> animateTo(SheetStage stage, {Duration duration = kDefaultDuration, Curve curve = Curves.linear});
  /// Immediately jumps the sheet to [stage] with no animation.
  void jumpTo(SheetStage stage);
  /// Animates the sheet fully open ([SheetStage.expanded]).
  Future<void> open({Duration duration = kDefaultDuration, Curve curve = Curves.easeOut});
  /// Animates the sheet fully closed ([SheetStage.closed]).
  Future<void> close({Duration duration = kDefaultDuration, Curve curve = Curves.easeOut});
}
```
