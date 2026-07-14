import 'dart:math';

import 'package:shadcn_flutter/shadcn_flutter.dart';

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
  Widget wrapBackdrop(BuildContext context, Widget child, double t,
      {bool isRoot = true});

  /// The amount of space (per axis) freed by this transform for a backdrop of
  /// [size] at progress [t]. Returns [Size.zero] when nothing is freed.
  Size resolveExtraSize(Size size, double t, {bool isRoot = true});
}

/// A [BackdropTransform] that leaves the backdrop untouched.
class NoBackdropTransform extends BackdropTransform {
  /// Creates an identity backdrop transform.
  const NoBackdropTransform();

  @override
  Widget wrapBackdrop(BuildContext context, Widget child, double t,
          {bool isRoot = true}) =>
      child;

  @override
  Size resolveExtraSize(Size size, double t, {bool isRoot = true}) => Size.zero;
}

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
  const ScaleBackdropTransform({
    this.minScale = kBackdropScaleDown,
    this.cornerRadius,
  });

  /// The scale factor at progress [t] (1.0 at t=0, [minScale] at t=1).
  double scaleAt(double t) => 1 - (1 - minScale) * t;

  @override
  Widget wrapBackdrop(BuildContext context, Widget child, double t,
      {bool isRoot = true}) {
    final scale = scaleAt(t);
    Widget result = child;
    if (isRoot) {
      final radius = cornerRadius ?? Theme.of(context).radiusXxl;
      result = ClipRRect(
        borderRadius: BorderRadius.circular(radius * t),
        child: result,
      );
    }
    return Transform.scale(scale: scale, child: result);
  }

  @override
  Size resolveExtraSize(Size size, double t, {bool isRoot = true}) {
    final scale = scaleAt(t);
    final sizeAfterScale = Size(size.width * scale, size.height * scale);
    if (isRoot) {
      // The root layer divides by the scale factor so the freed space maps back
      // into the un-scaled coordinate space of the drawer that fills it. Clamp
      // to zero: at low t the division can produce a small negative value, but
      // the backdrop never frees negative space.
      return Size(
        max(0.0, size.width - sizeAfterScale.width / minScale),
        max(0.0, size.height - sizeAfterScale.height / minScale),
      );
    }
    return Size(
      max(0.0, size.width - sizeAfterScale.width),
      max(0.0, size.height - sizeAfterScale.height),
    );
  }
}
