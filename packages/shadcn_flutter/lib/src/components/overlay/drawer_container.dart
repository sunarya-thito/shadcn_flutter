import 'dart:math';

import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A cross-axis size for a drawer/sheet container, resolved against the
/// available cross-axis extent. Used by [DrawerContainer]/[SheetContainer] to
/// size the sheet so it doesn't stretch edge-to-edge.
///
/// Supports arithmetic: `AxisSize.fraction(0.5) + AxisSize.fixed(40)`,
/// `AxisSize.fixed(400) * 0.5`, etc.
abstract class AxisSize {
  /// Const constructor for subclasses.
  const AxisSize();

  /// A fixed number of logical pixels.
  const factory AxisSize.fixed(double size) = FixedAxisSize;

  /// A [fraction] (0..1) of the available cross-axis extent.
  const factory AxisSize.fraction(double fraction) = FractionAxisSize;

  /// Resolves this size against the [available] cross-axis extent.
  double resolve(double available);

  /// Sum of two sizes.
  AxisSize operator +(AxisSize other) => AdditiveAxisSize(this, other);

  /// Difference of two sizes.
  AxisSize operator -(AxisSize other) => SubtractedAxisSize(this, other);

  /// Scales this size by [factor].
  AxisSize operator *(double factor) => MultipliedAxisSize(this, factor);

  /// Divides this size by [factor].
  AxisSize operator /(double factor) => DividedAxisSize(this, factor);
}

/// An [AxisSize] of a fixed number of logical pixels.
class FixedAxisSize extends AxisSize {
  /// The size in logical pixels.
  final double size;

  /// Creates a fixed axis size.
  const FixedAxisSize(this.size);

  @override
  double resolve(double available) => size;
}

/// An [AxisSize] that is a fraction of the available extent.
class FractionAxisSize extends AxisSize {
  /// The fraction (0..1) of the available extent.
  final double fraction;

  /// Creates a fractional axis size.
  const FractionAxisSize(this.fraction);

  @override
  double resolve(double available) => available * fraction;
}

/// Sum of two [AxisSize]s.
class AdditiveAxisSize extends AxisSize {
  /// The left operand.
  final AxisSize a;

  /// The right operand.
  final AxisSize b;

  /// Creates an additive axis size.
  const AdditiveAxisSize(this.a, this.b);

  @override
  double resolve(double available) =>
      a.resolve(available) + b.resolve(available);
}

/// Difference of two [AxisSize]s.
class SubtractedAxisSize extends AxisSize {
  /// The left operand.
  final AxisSize a;

  /// The right operand.
  final AxisSize b;

  /// Creates a subtracted axis size.
  const SubtractedAxisSize(this.a, this.b);

  @override
  double resolve(double available) =>
      a.resolve(available) - b.resolve(available);
}

/// An [AxisSize] scaled by a scalar factor.
class MultipliedAxisSize extends AxisSize {
  /// The operand.
  final AxisSize size;

  /// The scalar factor.
  final double factor;

  /// Creates a multiplied axis size.
  const MultipliedAxisSize(this.size, this.factor);

  @override
  double resolve(double available) => size.resolve(available) * factor;
}

/// An [AxisSize] divided by a scalar factor.
class DividedAxisSize extends AxisSize {
  /// The operand.
  final AxisSize size;

  /// The scalar divisor.
  final double factor;

  /// Creates a divided axis size.
  const DividedAxisSize(this.size, this.factor);

  @override
  double resolve(double available) => size.resolve(available) / factor;
}

/// The visual chrome of a drawer: background decoration with a border and
/// rounded outer corners, an optional drag handle, optional surface blur, and
/// an optional [ModalBackdrop] barrier.
///
/// This widget is the reusable container extracted from the drawer/sheet
/// overlay implementation. It is used both by the imperative drawer overlays
/// ([DrawerWrapper]) and by the controller-driven [PinnedSheet].
///
/// The drag *gesture* is intentionally not owned here — callers wrap this
/// container in their own gesture detector. This container only lays out the
/// handle and content (including the overscroll growth) and paints the
/// decoration/barrier.
///
/// This is the fully-parameterized form. For a form that reads its
/// configuration from an ancestor [DrawerContainerData] and only takes a
/// [child], use [DrawerContainer].
class DrawerRawContainer extends StatelessWidget {
  /// The resolved position (never [OverlayPosition.start]/[OverlayPosition.end]).
  final OverlayPosition position;

  /// The sheet content.
  final Widget child;

  /// Whether the container expands to fill the cross axis.
  final bool expands;

  /// Whether to lay out the draggable content (handle gaps + overscroll growth).
  final bool draggable;

  /// Whether to show the drag handle bar.
  final bool showDragHandle;

  /// Explicit drag handle size, or null for the density-derived default.
  final Size? dragHandleSize;

  /// Corner radius override for the drawer.
  final BorderRadiusGeometry? borderRadius;

  /// Inner content padding.
  final EdgeInsets padding;

  /// Outer margin around the container (used by sheets for safe-area insets).
  final EdgeInsets margin;

  /// Surface opacity for the background.
  final double? surfaceOpacity;

  /// Surface blur amount for the background.
  final double? surfaceBlur;

  /// Barrier color for the [ModalBackdrop].
  final Color? barrierColor;

  /// Stack index (0 = top-most). Affects opacity/barrier weakening.
  final int stackIndex;

  /// Gap before the drag handle.
  final double? gapBeforeDragger;

  /// Gap after the drag handle.
  final double? gapAfterDragger;

  /// Size constraints for the container.
  final BoxConstraints? constraints;

  /// Alignment of the container within its constraints.
  final AlignmentGeometry? alignment;

  /// Fade animation driving the [ModalBackdrop]. When null, no barrier is drawn.
  final Animation<double>? fadeAnimation;

  /// Extra space (freed by the backdrop transform) consumed on the outer edge.
  final Size extraSize;

  /// Live overscroll (drag past fully-open) in logical pixels.
  final double overscroll;

  /// The measured content size, used for the overscroll growth divisor.
  final Size size;

  /// Optional wrapper applied around the inner handle+content layout, used by
  /// callers to attach a drag gesture that stays inside the decoration.
  final Widget Function(BuildContext context, Widget layout)? gestureWrapper;

  /// Cross-axis padding on the leading edge (left for top/bottom, top for
  /// left/right).
  final double startPadding;

  /// Cross-axis padding on the trailing edge (right for top/bottom, bottom for
  /// left/right).
  final double endPadding;

  /// Optional explicit cross-axis size. When set, the sheet does not stretch
  /// edge-to-edge; it is sized to this and positioned by [crossAxisAlignment].
  final AxisSize? crossAxisSize;

  /// Cross-axis alignment in `[-1, 1]` (-1 = start, 0 = center, 1 = end). Only
  /// meaningful when [crossAxisSize] bounds the sheet smaller than the axis.
  final double crossAxisAlignment;

  /// Creates a drawer container.
  const DrawerRawContainer({
    super.key,
    required this.position,
    required this.child,
    required this.size,
    required this.stackIndex,
    this.expands = false,
    this.draggable = true,
    this.showDragHandle = true,
    this.dragHandleSize,
    this.borderRadius,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.barrierColor,
    this.gapBeforeDragger,
    this.gapAfterDragger,
    this.constraints,
    this.alignment,
    this.fadeAnimation,
    this.extraSize = Size.zero,
    this.overscroll = 0,
    this.gestureWrapper,
    this.startPadding = 0,
    this.endPadding = 0,
    this.crossAxisSize,
    this.crossAxisAlignment = 0,
  });

  bool get _crossIsHorizontal =>
      position == OverlayPosition.top || position == OverlayPosition.bottom;

  double? get _expandingWidth {
    switch (position) {
      case OverlayPosition.top:
      case OverlayPosition.bottom:
        return double.infinity;
      default:
        return null;
    }
  }

  double? get _expandingHeight {
    switch (position) {
      case OverlayPosition.left:
      case OverlayPosition.right:
        return double.infinity;
      default:
        return null;
    }
  }

  /// The border drawn around the drawer. Drawers border three sides.
  @protected
  Border getBorder(ThemeData theme) {
    switch (position) {
      case OverlayPosition.left:
        return Border(
          right: BorderSide(color: theme.colorScheme.border),
          top: BorderSide(color: theme.colorScheme.border),
          bottom: BorderSide(color: theme.colorScheme.border),
        );
      case OverlayPosition.right:
        return Border(
          left: BorderSide(color: theme.colorScheme.border),
          top: BorderSide(color: theme.colorScheme.border),
          bottom: BorderSide(color: theme.colorScheme.border),
        );
      case OverlayPosition.top:
        return Border(
          left: BorderSide(color: theme.colorScheme.border),
          right: BorderSide(color: theme.colorScheme.border),
          bottom: BorderSide(color: theme.colorScheme.border),
        );
      case OverlayPosition.bottom:
        return Border(
          left: BorderSide(color: theme.colorScheme.border),
          right: BorderSide(color: theme.colorScheme.border),
          top: BorderSide(color: theme.colorScheme.border),
        );
      default:
        throw UnimplementedError('Unknown position');
    }
  }

  /// The border radius applied to the two outer corners.
  @protected
  BorderRadiusGeometry getBorderRadius(double radius) {
    switch (position) {
      case OverlayPosition.left:
        return BorderRadius.only(
          topRight: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        );
      case OverlayPosition.right:
        return BorderRadius.only(
          topLeft: Radius.circular(radius),
          bottomLeft: Radius.circular(radius),
        );
      case OverlayPosition.top:
        return BorderRadius.only(
          bottomLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        );
      case OverlayPosition.bottom:
        return BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        );
      default:
        throw UnimplementedError('Unknown position');
    }
  }

  /// The decoration (background + border + radius) painted behind the content.
  @protected
  BoxDecoration getDecoration(ThemeData theme) {
    final border = getBorder(theme);
    final radius = borderRadius ?? getBorderRadius(theme.radiusXxl);
    var backgroundColor = theme.colorScheme.background;
    var opacity = surfaceOpacity ?? theme.surfaceOpacity;
    if (opacity != null && opacity < 1) {
      if (stackIndex == 0) {
        // The top sheet gets a higher opacity to prevent visual bleeding from
        // the main content.
        opacity = opacity * 1.25;
      }
      backgroundColor = backgroundColor.scaleAlpha(opacity);
    }
    return BoxDecoration(
      borderRadius: radius,
      color: backgroundColor,
      border: border,
    );
  }

  /// The drag handle bar widget.
  @protected
  Widget buildDragHandle(ThemeData theme) {
    final densityGap = theme.density.baseGap * theme.scaling;
    switch (position) {
      case OverlayPosition.left:
      case OverlayPosition.right:
        return Container(
          width: dragHandleSize?.width ?? densityGap * 0.75,
          height: dragHandleSize?.height ?? densityGap * 12.5,
          decoration: BoxDecoration(
            color: theme.colorScheme.muted,
            borderRadius: theme.borderRadiusXxl,
          ),
        );
      case OverlayPosition.top:
      case OverlayPosition.bottom:
        return Container(
          width: dragHandleSize?.width ?? densityGap * 12.5,
          height: dragHandleSize?.height ?? densityGap * 0.75,
          decoration: BoxDecoration(
            color: theme.colorScheme.muted,
            borderRadius: theme.borderRadiusXxl,
          ),
        );
      default:
        throw UnimplementedError('Unknown position');
    }
  }

  Widget _buildContent(BuildContext context, ThemeData theme) {
    if (!draggable) {
      return child;
    }
    final densityGap = theme.density.baseGap * theme.scaling;
    final over = max(0.0, overscroll);
    final handle = <Widget>[
      if (showDragHandle) buildDragHandle(theme),
    ];
    final gapAfter = gapAfterDragger ?? densityGap * 2;
    final gapBefore = gapBeforeDragger ?? densityGap * 1.5;
    switch (position) {
      case OverlayPosition.left:
        return Row(
          textDirection: TextDirection.ltr,
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(max(0.0, extraSize.width + over)),
            Flexible(
              child: Transform.scale(
                scaleX: 1 + overscroll / size.width / 4,
                alignment: Alignment.centerRight,
                child: child,
              ),
            ),
            if (showDragHandle) ...[
              Gap(gapAfter),
              ...handle,
              Gap(gapBefore),
            ],
          ],
        );
      case OverlayPosition.right:
        return Row(
          textDirection: TextDirection.ltr,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showDragHandle) ...[
              Gap(gapBefore),
              ...handle,
              Gap(gapAfter),
            ],
            Flexible(
              child: Transform.scale(
                scaleX: 1 + overscroll / size.width / 4,
                alignment: Alignment.centerLeft,
                child: child,
              ),
            ),
            Gap(max(0.0, extraSize.width + over)),
          ],
        );
      case OverlayPosition.top:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(max(0.0, extraSize.height + over)),
            Flexible(
              child: Transform.scale(
                scaleY: 1 + overscroll / size.height / 4,
                alignment: Alignment.bottomCenter,
                child: child,
              ),
            ),
            if (showDragHandle) ...[
              Gap(gapAfter),
              ...handle,
              Gap(gapBefore),
            ],
          ],
        );
      case OverlayPosition.bottom:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showDragHandle) ...[
              Gap(gapBefore),
              ...handle,
              Gap(gapAfter),
            ],
            Flexible(
              child: Transform.scale(
                scaleY: 1 + overscroll / size.height / 4,
                alignment: Alignment.topCenter,
                child: child,
              ),
            ),
            Gap(max(0.0, extraSize.height + over)),
          ],
        );
      default:
        throw UnimplementedError('Unknown position');
    }
  }

  bool get _hasCrossLayout =>
      crossAxisSize != null ||
      startPadding != 0 ||
      endPadding != 0 ||
      crossAxisAlignment != 0;

  EdgeInsets get _crossPadding => _crossIsHorizontal
      ? EdgeInsets.only(left: startPadding, right: endPadding)
      : EdgeInsets.only(top: startPadding, bottom: endPadding);

  Widget _buildDecorated(
      BuildContext context, double? crossWidth, double? crossHeight) {
    final theme = Theme.of(context);
    final blur = surfaceBlur ?? theme.surfaceBlur;
    final opacity = surfaceOpacity ?? theme.surfaceOpacity;
    final radius = borderRadius ?? getBorderRadius(theme.radiusXxl);

    Widget content = _buildContent(context, theme);
    if (gestureWrapper != null) {
      content = gestureWrapper!(context, content);
    }

    Widget container = Container(
      width: crossWidth,
      height: crossHeight,
      decoration: getDecoration(theme),
      padding: padding,
      margin: margin,
      child: content,
    );

    if (constraints != null) {
      container = ConstrainedBox(constraints: constraints!, child: container);
    }
    if (alignment != null) {
      container = Align(alignment: alignment!, child: container);
    }
    if (blur != null && blur > 0) {
      container = SurfaceBlur(
        surfaceBlur: blur,
        borderRadius: getBorderRadius(theme.radiusXxl),
        child: container,
      );
    }

    final animation = fadeAnimation;
    if (animation != null) {
      var color = barrierColor ?? Colors.black.scaleAlpha(0.8);
      if (stackIndex != 0) {
        // Weaken the barrier for upper (stacked) sheets.
        color = color.scaleAlpha(0.75);
      }
      container = ModalBackdrop(
        surfaceClip: ModalBackdrop.shouldClipSurface(opacity),
        borderRadius: radius,
        barrierColor: color,
        fadeAnimation: animation,
        padding: margin,
        child: container,
      );
    }
    return container;
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasCrossLayout) {
      return _buildDecorated(
        context,
        expands ? _expandingWidth : null,
        expands ? _expandingHeight : null,
      );
    }
    return LayoutBuilder(builder: (context, constraints) {
      final crossAvailRaw =
          _crossIsHorizontal ? constraints.maxWidth : constraints.maxHeight;
      final crossAvail = crossAvailRaw.isFinite
          ? crossAvailRaw
          : (_crossIsHorizontal ? size.width : size.height);
      final paddedAvail = max(0.0, crossAvail - startPadding - endPadding);
      double? crossExtent;
      if (crossAxisSize != null) {
        crossExtent = min(crossAxisSize!.resolve(paddedAvail), paddedAvail);
      } else if (expands) {
        crossExtent = paddedAvail;
      }

      Widget decorated = _buildDecorated(
        context,
        _crossIsHorizontal ? crossExtent : null,
        _crossIsHorizontal ? null : crossExtent,
      );

      if (startPadding != 0 || endPadding != 0) {
        decorated = Padding(padding: _crossPadding, child: decorated);
      }

      final align = crossAxisAlignment.clamp(-1.0, 1.0);
      final mainAxisAlignment = align < 0
          ? MainAxisAlignment.start
          : (align > 0 ? MainAxisAlignment.end : MainAxisAlignment.center);

      return _crossIsHorizontal
          ? Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: mainAxisAlignment,
              children: [decorated],
            )
          : Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: mainAxisAlignment,
              children: [decorated],
            );
    });
  }
}

/// The sheet variant of [DrawerRawContainer]: no rounded corners, only a single
/// inner border, and safe-area handled via an outer margin.
class SheetRawContainer extends DrawerRawContainer {
  /// Creates a sheet container.
  const SheetRawContainer({
    super.key,
    required super.position,
    required super.child,
    required super.size,
    required super.stackIndex,
    super.expands = true,
    super.draggable = false,
    super.showDragHandle = true,
    super.dragHandleSize,
    super.padding,
    super.margin,
    super.surfaceOpacity,
    super.surfaceBlur,
    super.barrierColor,
    super.gapBeforeDragger,
    super.gapAfterDragger,
    super.constraints,
    super.alignment,
    super.fadeAnimation,
    super.extraSize,
    super.overscroll,
    super.gestureWrapper,
    super.startPadding,
    super.endPadding,
    super.crossAxisSize,
    super.crossAxisAlignment,
  });

  @override
  Border getBorder(ThemeData theme) {
    switch (position) {
      case OverlayPosition.left:
        return Border(right: BorderSide(color: theme.colorScheme.border));
      case OverlayPosition.right:
        return Border(left: BorderSide(color: theme.colorScheme.border));
      case OverlayPosition.top:
        return Border(bottom: BorderSide(color: theme.colorScheme.border));
      case OverlayPosition.bottom:
        return Border(top: BorderSide(color: theme.colorScheme.border));
      default:
        throw UnimplementedError('Unknown position');
    }
  }

  @override
  BorderRadiusGeometry getBorderRadius(double radius) => BorderRadius.zero;

  @override
  BoxDecoration getDecoration(ThemeData theme) {
    var backgroundColor = theme.colorScheme.background;
    var opacity = surfaceOpacity ?? theme.surfaceOpacity;
    if (opacity != null && opacity < 1) {
      if (stackIndex == 0) {
        opacity = opacity * 1.25;
      }
      backgroundColor = backgroundColor.scaleAlpha(opacity);
    }
    return BoxDecoration(
      color: backgroundColor,
      border: getBorder(theme),
    );
  }
}

/// The configuration for a [DrawerContainer], provided to descendants via a
/// [Data] widget. A [DrawerContainer] reads this and builds the appropriate
/// raw container (drawer or sheet) around its child.
///
/// This lets a content builder wrap arbitrary content in a bare
/// `DrawerContainer(child: ...)` without threading every visual parameter
/// through the builder.
class DrawerContainerData {
  /// The resolved position.
  final OverlayPosition position;

  /// The measured content size.
  final Size size;

  /// The stack index (0 = top-most).
  final int stackIndex;

  /// Whether the container expands along the cross axis.
  final bool expands;

  /// Whether to lay out the draggable content.
  final bool draggable;

  /// Whether to show the drag handle.
  final bool showDragHandle;

  /// Explicit drag handle size.
  final Size? dragHandleSize;

  /// Corner radius override.
  final BorderRadiusGeometry? borderRadius;

  /// Inner content padding.
  final EdgeInsets padding;

  /// Outer margin.
  final EdgeInsets margin;

  /// Surface opacity.
  final double? surfaceOpacity;

  /// Surface blur.
  final double? surfaceBlur;

  /// Barrier color.
  final Color? barrierColor;

  /// Gap before the drag handle.
  final double? gapBeforeDragger;

  /// Gap after the drag handle.
  final double? gapAfterDragger;

  /// Size constraints.
  final BoxConstraints? constraints;

  /// Alignment within constraints.
  final AlignmentGeometry? alignment;

  /// Fade animation driving the [ModalBackdrop].
  final Animation<double>? fadeAnimation;

  /// Extra freed space consumed on the outer edge.
  final Size extraSize;

  /// Live overscroll in logical pixels.
  final double overscroll;

  /// Creates a drawer container configuration.
  const DrawerContainerData({
    required this.position,
    required this.size,
    required this.stackIndex,
    this.expands = false,
    this.draggable = true,
    this.showDragHandle = true,
    this.dragHandleSize,
    this.borderRadius,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.barrierColor,
    this.gapBeforeDragger,
    this.gapAfterDragger,
    this.constraints,
    this.alignment,
    this.fadeAnimation,
    this.extraSize = Size.zero,
    this.overscroll = 0,
  });

  /// Builds a [DrawerRawContainer] around [child] using this configuration.
  Widget buildDrawer(
    Widget child, {
    double startPadding = 0,
    double endPadding = 0,
    AxisSize? crossAxisSize,
    double crossAxisAlignment = 0,
  }) {
    return DrawerRawContainer(
      position: position,
      size: size,
      stackIndex: stackIndex,
      expands: expands,
      draggable: draggable,
      showDragHandle: showDragHandle,
      dragHandleSize: dragHandleSize,
      borderRadius: borderRadius,
      padding: padding,
      margin: margin,
      surfaceOpacity: surfaceOpacity,
      surfaceBlur: surfaceBlur,
      barrierColor: barrierColor,
      gapBeforeDragger: gapBeforeDragger,
      gapAfterDragger: gapAfterDragger,
      constraints: constraints,
      alignment: alignment,
      fadeAnimation: fadeAnimation,
      extraSize: extraSize,
      overscroll: overscroll,
      startPadding: startPadding,
      endPadding: endPadding,
      crossAxisSize: crossAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      child: child,
    );
  }

  /// Builds a [SheetRawContainer] around [child] using this configuration.
  Widget buildSheet(
    Widget child, {
    double startPadding = 0,
    double endPadding = 0,
    AxisSize? crossAxisSize,
    double crossAxisAlignment = 0,
  }) {
    return SheetRawContainer(
      position: position,
      size: size,
      stackIndex: stackIndex,
      expands: expands,
      draggable: draggable,
      showDragHandle: showDragHandle,
      dragHandleSize: dragHandleSize,
      padding: padding,
      margin: margin,
      surfaceOpacity: surfaceOpacity,
      surfaceBlur: surfaceBlur,
      barrierColor: barrierColor,
      gapBeforeDragger: gapBeforeDragger,
      gapAfterDragger: gapAfterDragger,
      constraints: constraints,
      alignment: alignment,
      fadeAnimation: fadeAnimation,
      extraSize: extraSize,
      overscroll: overscroll,
      startPadding: startPadding,
      endPadding: endPadding,
      crossAxisSize: crossAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      child: child,
    );
  }
}

/// A drawer container that takes only a [child] and reads the rest of its
/// configuration from an ancestor [DrawerContainerData] (provided via a [Data]
/// widget, e.g. by a [PinnedSheet]). Delegates to [DrawerRawContainer].
///
/// The caller may additionally control cross-axis padding ([startPadding],
/// [endPadding]), the cross-axis [size], and [alignment] (-1 start, 0 center,
/// 1 end; or the [DrawerContainer.alignStart]/[alignCenter]/[alignEnd]
/// constructors).
class DrawerContainer extends StatelessWidget {
  /// The sheet content.
  final Widget child;

  /// Cross-axis padding on the leading edge.
  final double startPadding;

  /// Cross-axis padding on the trailing edge.
  final double endPadding;

  /// Optional cross-axis size (so the sheet doesn't stretch edge-to-edge).
  final AxisSize? size;

  /// Cross-axis alignment in `[-1, 1]`.
  final double alignment;

  /// When true, the sheet content is sized along the main axis to the currently
  /// visible extent (0 when closed, the backdrop extent when fully open) instead
  /// of sliding a fixed-size child. See [intrinsic].
  final bool expands;

  /// When [expands] is true, floors the sheet's main-axis size at the child's
  /// intrinsic size so it stops shrinking (preventing overflow) rather than
  /// clipping the content down to nothing. Defaults to true.
  final bool intrinsic;

  /// Creates a data-driven drawer container.
  const DrawerContainer({
    super.key,
    required this.child,
    this.startPadding = 0,
    this.endPadding = 0,
    this.size,
    this.alignment = 0,
    this.expands = false,
    this.intrinsic = true,
  });

  /// A drawer container aligned to the cross-axis start.
  const DrawerContainer.alignStart({
    super.key,
    required this.child,
    this.startPadding = 0,
    this.endPadding = 0,
    this.size,
    this.expands = false,
    this.intrinsic = true,
  }) : alignment = -1;

  /// A drawer container centered on the cross axis.
  const DrawerContainer.alignCenter({
    super.key,
    required this.child,
    this.startPadding = 0,
    this.endPadding = 0,
    this.size,
    this.expands = false,
    this.intrinsic = true,
  }) : alignment = 0;

  /// A drawer container aligned to the cross-axis end.
  const DrawerContainer.alignEnd({
    super.key,
    required this.child,
    this.startPadding = 0,
    this.endPadding = 0,
    this.size,
    this.expands = false,
    this.intrinsic = true,
  }) : alignment = 1;

  @override
  Widget build(BuildContext context) {
    return Data.of<DrawerContainerData>(context).buildDrawer(
      child,
      startPadding: startPadding,
      endPadding: endPadding,
      crossAxisSize: size,
      crossAxisAlignment: alignment,
    );
  }
}

/// A sheet container that takes only a [child] and reads the rest of its
/// configuration from an ancestor [DrawerContainerData] (provided via a [Data]
/// widget, e.g. by a [PinnedSheet]). Delegates to [SheetRawContainer].
class SheetContainer extends StatelessWidget {
  /// The sheet content.
  final Widget child;

  /// Cross-axis padding on the leading edge.
  final double startPadding;

  /// Cross-axis padding on the trailing edge.
  final double endPadding;

  /// Optional cross-axis size (so the sheet doesn't stretch edge-to-edge).
  final AxisSize? size;

  /// Cross-axis alignment in `[-1, 1]`.
  final double alignment;

  /// See [DrawerContainer.expands].
  final bool expands;

  /// See [DrawerContainer.intrinsic].
  final bool intrinsic;

  /// Creates a data-driven sheet container.
  const SheetContainer({
    super.key,
    required this.child,
    this.startPadding = 0,
    this.endPadding = 0,
    this.size,
    this.alignment = 0,
    this.expands = false,
    this.intrinsic = true,
  });

  /// A sheet container aligned to the cross-axis start.
  const SheetContainer.alignStart({
    super.key,
    required this.child,
    this.startPadding = 0,
    this.endPadding = 0,
    this.size,
    this.expands = false,
    this.intrinsic = true,
  }) : alignment = -1;

  /// A sheet container centered on the cross axis.
  const SheetContainer.alignCenter({
    super.key,
    required this.child,
    this.startPadding = 0,
    this.endPadding = 0,
    this.size,
    this.expands = false,
    this.intrinsic = true,
  }) : alignment = 0;

  /// A sheet container aligned to the cross-axis end.
  const SheetContainer.alignEnd({
    super.key,
    required this.child,
    this.startPadding = 0,
    this.endPadding = 0,
    this.size,
    this.expands = false,
    this.intrinsic = true,
  }) : alignment = 1;

  @override
  Widget build(BuildContext context) {
    return Data.of<DrawerContainerData>(context).buildSheet(
      child,
      startPadding: startPadding,
      endPadding: endPadding,
      crossAxisSize: size,
      crossAxisAlignment: alignment,
    );
  }
}
