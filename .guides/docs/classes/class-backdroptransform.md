---
title: "Class: BackdropTransform"
description: "Describes how the content behind a sheet/drawer ([the backdrop]) is  transformed as the sheet animates between closed ([t] == 0) and fully  open ([t] == 1).   Implementations control both the visual wrapping ([wrapBackdrop]) and the  amount of layout space the transform frees along each axis  ([resolveExtraSize]). The freed space is what allows a drawer to slide into  the gap opened by scaling the backdrop down, and is propagated across nested  sheets via [BackdropTransformData].   The default implementation is [ScaleBackdropTransform], which scales the  backdrop from `1.0` down to a smaller factor (see [kBackdropScaleDown])."
---

```dart
/// Describes how the content behind a sheet/drawer ([the backdrop]) is
/// transformed as the sheet animates between closed ([t] == 0) and fully
/// open ([t] == 1).
///
/// Implementations control both the visual wrapping ([wrapBackdrop]) and the
/// amount of layout space the transform frees along each axis
/// ([resolveExtraSize]). The freed space is what allows a drawer to slide into
/// the gap opened by scaling the backdrop down, and is propagated across nested
/// sheets via [BackdropTransformData].
///
/// The default implementation is [ScaleBackdropTransform], which scales the
/// backdrop from `1.0` down to a smaller factor (see [kBackdropScaleDown]).
abstract class BackdropTransform {
  /// Const constructor for subclasses.
  const BackdropTransform();
  /// A transform that does nothing: the backdrop is untouched and no extra
  /// layout space is produced. Used by sheets that do not scale the backdrop.
  static const BackdropTransform none = NoBackdropTransform();
  /// Wraps [child] (the backdrop content) with the visual transform for
  /// progress [t] (0 = closed, 1 = fully open).
  ///
  /// [isRoot] is true for the bottom-most layer in a stack of sheets (the one
  /// that wraps the actual app content); root layers may additionally clip
  /// their corners as they scale in.
  Widget wrapBackdrop(BuildContext context, Widget child, double t, {bool isRoot = true});
  /// The amount of space (per axis) freed by this transform for a backdrop of
  /// [size] at progress [t]. Returns [Size.zero] when nothing is freed.
  Size resolveExtraSize(Size size, double t, {bool isRoot = true});
}
```
