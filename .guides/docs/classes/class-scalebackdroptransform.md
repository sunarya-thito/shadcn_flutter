---
title: "Class: ScaleBackdropTransform"
description: "The default [BackdropTransform]: scales the backdrop down from `1.0` to  [minScale] as the sheet opens, and (for the root layer) clips its corners  with an animated radius.   This reproduces the classic drawer \"zoom-out\" effect where the underlying  content shrinks slightly to reveal the drawer sliding in from the edge."
---

```dart
/// The default [BackdropTransform]: scales the backdrop down from `1.0` to
/// [minScale] as the sheet opens, and (for the root layer) clips its corners
/// with an animated radius.
///
/// This reproduces the classic drawer "zoom-out" effect where the underlying
/// content shrinks slightly to reveal the drawer sliding in from the edge.
class ScaleBackdropTransform extends BackdropTransform {
  /// The scale applied to the backdrop when fully open. Defaults to
  /// [kBackdropScaleDown] (0.95).
  final double minScale;
  /// The corner radius the root backdrop clips to when fully open. When null,
  /// `Theme.of(context).radiusXxl` is used.
  final double? cornerRadius;
  /// Creates a scaling backdrop transform.
  const ScaleBackdropTransform({this.minScale = kBackdropScaleDown, this.cornerRadius});
  /// The scale factor at progress [t] (1.0 at t=0, [minScale] at t=1).
  double scaleAt(double t);
  Widget wrapBackdrop(BuildContext context, Widget child, double t, {bool isRoot = true});
  Size resolveExtraSize(Size size, double t, {bool isRoot = true});
}
```
