import 'dart:ui';

import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Extra small padding multiplier (0.5).
///
/// At default density (base 16px), produces ~8px padding.
const padXs = 0.5;

/// Small padding multiplier (1.0).
///
/// At default density (base 16px), produces ~16px padding.
const padSm = 1.0;

/// Medium padding multiplier (1.5).
///
/// At default density (base 16px), produces ~24px padding.
const padMd = 1.5;

/// Standard/large padding multiplier (2.0).
///
/// At default density (base 16px), produces 32px padding.
/// This is the baseline multiplier for normal spacing.
const padLg = 2.0;

/// Extra large padding multiplier (2.5).
///
/// At default density (base 16px), produces ~40px padding.
const padXl = 2.5;

/// 2x extra large padding multiplier (3.0).
///
/// At default density (base 16px), produces ~48px padding.
const pad2xl = 3.0;

/// 3x extra large padding multiplier (3.5).
///
/// At default density (base 16px), produces ~56px padding.
const pad3xl = 3.5;

/// 4x extra large padding multiplier (4.0).
///
/// At default density (base 16px), produces ~64px padding.
const pad4xl = 4.0;

/// Extra small gap multiplier (0.5).
///
/// At default density (base 8px), produces ~4px gap.
const gapXs = 0.5;

/// Small gap multiplier (1.0).
///
/// At default density (base 8px), produces ~8px gap.
const gapSm = 1.0;

/// Medium gap multiplier (1.5).
///
/// At default density (base 8px), produces ~12px gap.
const gapMd = 1.5;

/// Standard/large gap multiplier (2.0).
///
/// At default density (base 8px), produces 16px gap.
/// This is the baseline multiplier for normal spacing.
const gapLg = 2.0;

/// Extra large gap multiplier (2.5).
///
/// At default density (base 8px), produces ~20px gap.
const gapXl = 2.5;

/// 2x extra large gap multiplier (3.0).
///
/// At default density (base 8px), produces ~24px gap.
const gap2xl = 3.0;

/// 3x extra large gap multiplier (3.5).
///
/// At default density (base 8px), produces ~28px gap.
const gap3xl = 3.5;

/// 4x extra large gap multiplier (4.0).
///
/// At default density (base 8px), produces ~32px gap.
const gap4xl = 4.0;

/// Defines density settings for spacing throughout the UI.
///
/// [Density] provides base values that are multiplied by padding constants
/// (e.g., [padXs], [padSm], [padLg]) to produce final pixel values.
/// This allows consistent scaling of all spacing when switching density modes.
///
/// There are two types of padding:
/// - **Container padding**: Used for widgets that contain multiple children
///   (e.g., Card, AlertDialog, ListView panels)
/// - **Content padding**: Used for widgets that contain content
///   (e.g., Button, TextField, Chip)
///
/// Example:
/// ```dart
/// // Apply compact density to reduce spacing
/// Theme(
///   data: ThemeData(density: Density.compactDensity),
///   child: MyApp(),
/// )
/// ```
class Density {
  /// Linearly interpolates between two density settings.
  ///
  /// Parameters:
  /// - [a] (`Density`, required): The starting density.
  /// - [b] (`Density`, required): The ending density.
  /// - [t] (`double`, required): The interpolation factor (0.0 to 1.0).
  static Density lerp(Density a, Density b, double t) {
    return Density(
      baseContainerPadding:
          lerpDouble(a.baseContainerPadding, b.baseContainerPadding, t)!,
      baseGap: lerpDouble(a.baseGap, b.baseGap, t)!,
      baseContentPadding:
          lerpDouble(a.baseContentPadding, b.baseContentPadding, t)!,
    );
  }

  /// Default density with standard spacing (16px base).
  static const defaultDensity = Density(
    baseContainerPadding: 16.0,
    baseGap: 8.0,
    baseContentPadding: 16.0,
  );

  /// Reduced density for slightly more compact layouts (12px base).
  static const reducedDensity = Density(
    baseContainerPadding: 12.0,
    baseGap: 6.0,
    baseContentPadding: 12.0,
  );

  /// Spacious density for more generous spacing (20px base).
  static const spaciousDensity = Density(
    baseContainerPadding: 20.0,
    baseGap: 10.0,
    baseContentPadding: 20.0,
  );

  /// Compact density for maximizing content density (8px base).
  static const compactDensity = Density(
    baseContainerPadding: 8.0,
    baseGap: 4.0,
    baseContentPadding: 8.0,
  );

  /// Base padding for container widgets (Card, AlertDialog, etc.).
  final double baseContainerPadding;

  /// Base gap between items in rows, columns, and flex layouts.
  final double baseGap;

  /// Base padding for content widgets (Button, TextField, etc.).
  final double baseContentPadding;

  /// Creates a [Density] with custom base values.
  ///
  /// Parameters:
  /// - [baseContainerPadding] (`double`, required): Base padding for containers.
  /// - [baseGap] (`double`, required): Base gap between items.
  /// - [baseContentPadding] (`double`, required): Base padding for content.
  const Density({
    required this.baseContainerPadding,
    required this.baseGap,
    required this.baseContentPadding,
  });

  /// Creates a copy of this density with the specified values replaced.
  Density copyWith({
    ValueGetter<double>? baseContainerPadding,
    ValueGetter<double>? baseGap,
    ValueGetter<double>? baseContentPadding,
  }) {
    return Density(
      baseContainerPadding: baseContainerPadding == null
          ? this.baseContainerPadding
          : baseContainerPadding(),
      baseGap: baseGap == null ? this.baseGap : baseGap(),
      baseContentPadding: baseContentPadding == null
          ? this.baseContentPadding
          : baseContentPadding(),
    );
  }

  @override
  String toString() {
    return 'Density(baseContainerPadding: $baseContainerPadding, baseGap: $baseGap, baseContentPadding: $baseContentPadding)';
  }

  @override
  bool operator ==(Object other) {
    return other is Density &&
        other.baseContainerPadding == baseContainerPadding &&
        other.baseGap == baseGap &&
        other.baseContentPadding == baseContentPadding;
  }

  @override
  int get hashCode =>
      Object.hash(baseContainerPadding, baseGap, baseContentPadding);
}

/// Interface for edge insets that can be resolved using density settings.
///
/// Implement this interface to create custom density-aware edge insets.
/// Use [DirectionalEdgeInsetsDensity] for RTL-aware insets or
/// [EdgeInsetsDensity] for fixed left/right insets.
abstract interface class DensityEdgeInsetsGeometry extends EdgeInsetsGeometry {
  /// Resolves the density multipliers to actual pixel values.
  ///
  /// Parameters:
  /// - [basePadding] (`double`, required): The base padding from [Density].
  EdgeInsetsGeometry resolveDensity(double basePadding);
}

/// Direction-aware density edge insets using start/end instead of left/right.
///
/// Use this for RTL-aware layouts. The [start] and [end] values are
/// multipliers that will be multiplied by the base padding from [Density].
///
/// Example:
/// ```dart
/// // Creates padding that adapts to density and text direction
/// const DirectionalEdgeInsetsDensity.symmetric(
///   horizontal: padLg,  // 1.0 * basePadding on start and end
///   vertical: padSm,    // 0.5 * basePadding on top and bottom
/// )
/// ```
class DirectionalEdgeInsetsDensity extends EdgeInsetsDirectional
    implements DensityEdgeInsetsGeometry {
  /// Creates directional density insets with individual values.
  ///
  /// All values default to 0.0 (no padding).
  const DirectionalEdgeInsetsDensity.only({
    super.start = 0.0,
    super.top = 0.0,
    super.end = 0.0,
    super.bottom = 0.0,
  }) : super.only();

  /// Creates directional density insets with the same value on all sides.
  const DirectionalEdgeInsetsDensity.all(double value) : super.all(value);

  /// Creates directional density insets with symmetric values.
  const DirectionalEdgeInsetsDensity.symmetric({
    super.vertical = 0.0,
    super.horizontal = 0.0,
  }) : super.symmetric();

  @override
  EdgeInsetsDirectional resolveDensity(double basePadding) {
    return EdgeInsetsDirectional.only(
      start: start * basePadding,
      top: top * basePadding,
      end: end * basePadding,
      bottom: bottom * basePadding,
    );
  }

  @override
  DirectionalEdgeInsetsDensity copyWith(
      {double? start, double? top, double? end, double? bottom}) {
    return DirectionalEdgeInsetsDensity.only(
      start: start ?? this.start,
      top: top ?? this.top,
      end: end ?? this.end,
      bottom: bottom ?? this.bottom,
    );
  }
}

/// Fixed direction density edge insets using left/right.
///
/// Use this when direction is fixed (not RTL-aware). Values are multipliers
/// that will be multiplied by the base padding from [Density].
///
/// Example:
/// ```dart
/// // Creates fixed padding that adapts to density
/// const EdgeInsetsDensity.symmetric(
///   horizontal: padLg,  // 1.0 * basePadding on left and right
///   vertical: padSm,    // 0.5 * basePadding on top and bottom
/// )
/// ```
class EdgeInsetsDensity extends EdgeInsets
    implements DensityEdgeInsetsGeometry {
  /// Creates density insets with individual values.
  const EdgeInsetsDensity.only({
    super.left = 0.0,
    super.top = 0.0,
    super.right = 0.0,
    super.bottom = 0.0,
  }) : super.only();

  /// Creates density insets with the same value on all sides.
  const EdgeInsetsDensity.all(double value) : super.all(value);

  /// Creates density insets with symmetric values.
  const EdgeInsetsDensity.symmetric({
    super.vertical = 0.0,
    super.horizontal = 0.0,
  }) : super.symmetric();

  @override
  EdgeInsets resolveDensity(double basePadding) {
    return EdgeInsets.only(
      left: left * basePadding,
      right: right * basePadding,
      top: top * basePadding,
      bottom: bottom * basePadding,
    );
  }

  @override
  EdgeInsetsDensity copyWith(
      {double? left, double? top, double? right, double? bottom}) {
    return EdgeInsetsDensity.only(
      left: left ?? this.left,
      top: top ?? this.top,
      right: right ?? this.right,
      bottom: bottom ?? this.bottom,
    );
  }
}

/// Resolves [EdgeInsetsGeometry] using the appropriate density base.
///
/// If [padding] implements [DensityEdgeInsetsGeometry], it is resolved
/// using [basePadding]. Otherwise, the original padding is returned unchanged.
///
/// This function is used internally by density widgets to resolve padding.
EdgeInsetsGeometry resolveEdgeInsets(
    EdgeInsetsGeometry padding, double basePadding) {
  return switch (padding) {
    DensityEdgeInsetsGeometry densityPadding =>
      densityPadding.resolveDensity(basePadding),
    _ => padding,
  };
}

/// A padding widget that resolves density insets using content padding base.
///
/// Use this for widgets that contain content (buttons, text fields, chips).
/// The padding is resolved using [Density.baseContentPadding].
///
/// Example:
/// ```dart
/// DensityContentPadding(
///   padding: const DirectionalEdgeInsetsDensity.symmetric(
///     horizontal: padLg,
///     vertical: padSm,
///   ),
///   child: Text('Button content'),
/// )
/// ```
class DensityContentPadding extends StatelessWidget {
  /// The padding to apply, can be density-aware or absolute.
  final EdgeInsetsGeometry padding;

  /// The child widget to apply padding to.
  final Widget child;

  /// Creates a [DensityContentPadding].
  ///
  /// Parameters:
  /// - [padding] (`EdgeInsetsGeometry`, required): The padding specification.
  /// - [child] (`Widget`, required): The child to wrap with padding.
  const DensityContentPadding({
    super.key,
    required this.padding,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedPadding = resolveEdgeInsets(
      padding,
      theme.density.baseContentPadding * theme.scaling,
    );
    return Padding(
      padding: resolvedPadding,
      child: child,
    );
  }
}

/// A padding widget that resolves density insets using container padding base.
///
/// Use this for widgets that contain multiple children (cards, dialogs, panels).
/// The padding is resolved using [Density.baseContainerPadding].
///
/// Example:
/// ```dart
/// DensityContainerPadding(
///   padding: const DirectionalEdgeInsetsDensity.all(padLg),
///   child: Column(children: [...]),
/// )
/// ```
class DensityContainerPadding extends StatelessWidget {
  /// The padding to apply, can be density-aware or absolute.
  final EdgeInsetsGeometry padding;

  /// The child widget to apply padding to.
  final Widget child;

  /// Creates a [DensityContainerPadding].
  ///
  /// Parameters:
  /// - [padding] (`EdgeInsetsGeometry`, required): The padding specification.
  /// - [child] (`Widget`, required): The child to wrap with padding.
  const DensityContainerPadding({
    super.key,
    required this.padding,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedPadding = resolveEdgeInsets(
      padding,
      theme.density.baseContainerPadding * theme.scaling,
    );
    return Padding(
      padding: resolvedPadding,
      child: child,
    );
  }
}

/// A gap widget that resolves spacing using density settings.
///
/// Use this instead of [Gap] when you want spacing to adapt to density.
/// The [gap] value is a multiplier applied to [Density.baseGap].
///
/// Example:
/// ```dart
/// Column(
///   children: [
///     Text('First'),
///     DensityGap(gap: gapLg),  // Gap adapts to density
///     Text('Second'),
///   ],
/// )
/// ```
class DensityGap extends StatelessWidget {
  /// The gap multiplier, applied to [Density.baseGap].
  final double gap;

  /// Creates a [DensityGap].
  ///
  /// Parameters:
  /// - [gap] (`double`, required): Gap multiplier (use constants like [gapLg]).
  const DensityGap(
    this.gap, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final adjustedGap = gap * theme.density.baseGap * theme.scaling;
    return Gap(adjustedGap);
  }
}

/// A row widget with density-aware spacing between children.
///
/// Use instead of [Row] when you want the spacing to adapt to density settings.
/// The [spacing] value is a multiplier applied to [Density.baseGap].
///
/// Example:
/// ```dart
/// DensityRow(
///   spacing: padLg,
///   children: [
///     Icon(Icons.star),
///     Text('Rating'),
///   ],
/// )
/// ```
class DensityRow extends StatelessWidget {
  /// The spacing multiplier between children.
  final double spacing;

  /// The children widgets.
  final List<Widget> children;

  /// How the children should be placed along the main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// How the children should be placed along the cross axis.
  final CrossAxisAlignment crossAxisAlignment;

  /// How much space should be occupied in the main axis.
  final MainAxisSize mainAxisSize;

  /// The text direction to use for rendering.
  final TextDirection? textDirection;

  /// The vertical direction to use for layout.
  final VerticalDirection verticalDirection;

  /// The baseline to use for aligning children.
  final TextBaseline? textBaseline;

  /// Creates a [DensityRow].
  ///
  /// Parameters:
  /// - [spacing] (`double`, default: 0): Gap multiplier between children.
  /// - [children] (`List<Widget>`, required): The row's children.
  const DensityRow({
    super.key,
    this.spacing = 0,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final adjustedSpacing = spacing * theme.density.baseGap * theme.scaling;
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      spacing: adjustedSpacing,
      children: children,
    );
  }
}

/// A column widget with density-aware spacing between children.
///
/// Use instead of [Column] when you want the spacing to adapt to density.
/// The [spacing] value is a multiplier applied to [Density.baseGap].
///
/// Example:
/// ```dart
/// DensityColumn(
///   spacing: padMd,
///   children: [
///     Text('Title'),
///     Text('Subtitle'),
///   ],
/// )
/// ```
class DensityColumn extends StatelessWidget {
  /// The spacing multiplier between children.
  final double spacing;

  /// The children widgets.
  final List<Widget> children;

  /// How the children should be placed along the main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// How the children should be placed along the cross axis.
  final CrossAxisAlignment crossAxisAlignment;

  /// How much space should be occupied in the main axis.
  final MainAxisSize mainAxisSize;

  /// The text direction to use for rendering.
  final TextDirection? textDirection;

  /// The vertical direction to use for layout.
  final VerticalDirection verticalDirection;

  /// The baseline to use for aligning children.
  final TextBaseline? textBaseline;

  /// Creates a [DensityColumn].
  ///
  /// Parameters:
  /// - [spacing] (`double`, default: 0): Gap multiplier between children.
  /// - [children] (`List<Widget>`, required): The column's children.
  const DensityColumn({
    super.key,
    this.spacing = 0,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final adjustedSpacing = spacing * theme.density.baseGap * theme.scaling;
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      spacing: adjustedSpacing,
      children: children,
    );
  }
}

/// A flex widget with density-aware spacing between children.
///
/// Use instead of [Flex] when you want the spacing to adapt to density.
/// The [spacing] value is a multiplier applied to [Density.baseGap].
///
/// Example:
/// ```dart
/// DensityFlex(
///   direction: Axis.horizontal,
///   spacing: padSm,
///   children: [
///     Chip(label: Text('Tag 1')),
///     Chip(label: Text('Tag 2')),
///   ],
/// )
/// ```
class DensityFlex extends StatelessWidget {
  /// The direction to use as the main axis.
  final Axis direction;

  /// The spacing multiplier between children.
  final double spacing;

  /// The children widgets.
  final List<Widget> children;

  /// How the children should be placed along the main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// How the children should be placed along the cross axis.
  final CrossAxisAlignment crossAxisAlignment;

  /// How much space should be occupied in the main axis.
  final MainAxisSize mainAxisSize;

  /// The text direction to use for rendering.
  final TextDirection? textDirection;

  /// The vertical direction to use for layout.
  final VerticalDirection verticalDirection;

  /// The baseline to use for aligning children.
  final TextBaseline? textBaseline;

  /// The clip behavior of the flex widget.
  final Clip clipBehavior;

  /// Creates a [DensityFlex].
  ///
  /// Parameters:
  /// - [direction] (`Axis`, required): The main axis direction.
  /// - [spacing] (`double`, default: 0): Gap multiplier between children.
  /// - [children] (`List<Widget>`, required): The flex's children.
  const DensityFlex({
    super.key,
    required this.direction,
    this.spacing = 0,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.clipBehavior = Clip.none,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final adjustedSpacing = spacing * theme.density.baseGap * theme.scaling;
    return Flex(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      clipBehavior: clipBehavior,
      spacing: adjustedSpacing,
      children: children,
    );
  }
}
