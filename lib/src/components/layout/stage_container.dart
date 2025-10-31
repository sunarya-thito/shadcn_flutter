import 'dart:math';

import '../../../shadcn_flutter.dart';

/// Abstract base class for defining stage-based layout breakpoints.
///
/// Provides strategies for determining minimum and maximum widths based on
/// container size. Used by [StageContainer] to create responsive layouts
/// that adapt to screen size in discrete steps.
abstract class StageBreakpoint {
  /// Creates a constant breakpoint with uniform stepping.
  ///
  /// Parameters:
  /// - [breakpoint] (`double`, required): Step size for width calculations.
  /// - [minSize] (`double`, default: `0`): Minimum allowed size.
  /// - [maxSize] (`double`, default: `double.infinity`): Maximum allowed size.
  factory StageBreakpoint.constant(
    double breakpoint, {
    double minSize = 0,
    double maxSize = double.infinity,
  }) {
    return ConstantBreakpoint(breakpoint, minSize: minSize, maxSize: maxSize);
  }

  /// Creates staged breakpoints from a list of specific width values.
  ///
  /// Parameters:
  /// - [breakpoints] (`List<double>`, required): List of breakpoint widths.
  factory StageBreakpoint.staged(List<double> breakpoints) {
    return StagedBreakpoint(breakpoints);
  }

  /// Default responsive breakpoints (576, 768, 992, 1200, 1400).
  ///
  /// Matches common responsive design breakpoints for mobile, tablet, desktop.
  static const StageBreakpoint defaultBreakpoints =
      StagedBreakpoint.defaultBreakpoints();

  /// Calculates the minimum width for the given container [width].
  double getMinWidth(double width);

  /// Calculates the maximum width for the given container [width].
  double getMaxWidth(double width);

  /// Minimum allowed size constraint.
  double get minSize;

  /// Maximum allowed size constraint.
  double get maxSize;
}

/// A breakpoint that uses constant step increments.
///
/// Divides width into uniform steps based on [breakpoint] value. For example,
/// with breakpoint=100, widths 0-99 map to 0, 100-199 map to 100, etc.
class ConstantBreakpoint implements StageBreakpoint {
  /// The step size for width calculations.
  final double breakpoint;

  @override
  final double minSize;

  @override
  final double maxSize;

  /// Creates a [ConstantBreakpoint].
  const ConstantBreakpoint(
    this.breakpoint, {
    this.minSize = 0,
    this.maxSize = double.infinity,
  });

  @override
  double getMinWidth(double width) {
    // 0 < width < breakpoint * 1 ? breakpoint * 1 : width
    // breakpoint * 1 < width < breakpoint * 2 ? breakpoint * 2 : width
    // etc
    return breakpoint * (width / breakpoint).floor();
  }

  @override
  double getMaxWidth(double width) {
    return breakpoint * (width / breakpoint).ceil();
  }
}

/// A breakpoint that uses predefined stage values.
///
/// Maps container widths to the nearest breakpoint value from a list.
/// Commonly used for responsive design with specific breakpoints like
/// mobile (576), tablet (768), desktop (992), etc.
class StagedBreakpoint implements StageBreakpoint {
  /// Default breakpoints matching common responsive design values.
  static const List<double> _defaultBreakpoints = [576, 768, 992, 1200, 1400];

  /// List of breakpoint width values in ascending order.
  final List<double> breakpoints;

  /// Creates a [StagedBreakpoint] with custom breakpoints.
  ///
  /// Requires at least 2 breakpoints.
  const StagedBreakpoint(this.breakpoints) : assert(breakpoints.length > 1);

  /// Creates a [StagedBreakpoint] with default responsive breakpoints.
  const StagedBreakpoint.defaultBreakpoints()
      : breakpoints = _defaultBreakpoints;

  @override
  double getMinWidth(double width) {
    for (int i = 1; i < breakpoints.length; i++) {
      if (width < breakpoints[i]) {
        return breakpoints[i - 1];
      }
    }
    return width;
  }

  @override
  double getMaxWidth(double width) {
    for (var breakpoint in breakpoints) {
      if (width < breakpoint) {
        return breakpoint;
      }
    }
    return maxSize;
  }

  @override
  double get minSize => breakpoints.first;

  @override
  double get maxSize => breakpoints.last;
}

/// Theme configuration for [StageContainer] responsive behavior.
///
/// Defines default breakpoint strategy and padding for stage containers.
class StageContainerTheme {
  /// The breakpoint strategy to use.
  final StageBreakpoint? breakpoint;

  /// Default padding for the container.
  final EdgeInsets? padding;

  /// Creates a [StageContainerTheme].
  const StageContainerTheme({this.breakpoint, this.padding});

  /// Creates a copy of this theme with the given fields replaced.
  StageContainerTheme copyWith({
    ValueGetter<StageBreakpoint?>? breakpoint,
    ValueGetter<EdgeInsets?>? padding,
  }) {
    return StageContainerTheme(
      breakpoint: breakpoint == null ? this.breakpoint : breakpoint(),
      padding: padding == null ? this.padding : padding(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StageContainerTheme &&
        other.breakpoint == breakpoint &&
        other.padding == padding;
  }

  @override
  int get hashCode => Object.hash(breakpoint, padding);
}

/// A responsive container that adapts to screen size using breakpoints.
///
/// Constrains child width based on breakpoint strategy and adds padding.
/// Useful for creating centered, responsive layouts that adapt smoothly
/// across different screen sizes.
///
/// Example:
/// ```dart
/// StageContainer(
///   breakpoint: StageBreakpoint.defaultBreakpoints,
///   padding: EdgeInsets.symmetric(horizontal: 24),
///   builder: (context, padding) {
///     return Container(
///       padding: padding,
///       child: Text('Responsive content'),
///     );
///   },
/// )
/// ```
class StageContainer extends StatelessWidget {
  /// The breakpoint strategy for determining container width.
  ///
  /// Defaults to [StageBreakpoint.defaultBreakpoints].
  final StageBreakpoint breakpoint;

  /// Builder function that receives context and calculated padding.
  ///
  /// The padding parameter accounts for responsive adjustments.
  final Widget Function(BuildContext context, EdgeInsets padding) builder;

  /// Base padding for the container.
  ///
  /// Defaults to `EdgeInsets.symmetric(horizontal: 72)`.
  final EdgeInsets padding;

  /// Creates a [StageContainer].
  const StageContainer({
    super.key,
    this.breakpoint = StageBreakpoint.defaultBreakpoints,
    required this.builder,
    this.padding = const EdgeInsets.symmetric(horizontal: 72),
  });

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<StageContainerTheme>(context);
    final StageBreakpoint breakpoint = compTheme?.breakpoint ?? this.breakpoint;
    final EdgeInsets padding = styleValue(
      defaultValue: this.padding,
      themeValue: compTheme?.padding,
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        var size = constraints.maxWidth;
        double topPadding = padding.top;
        double bottomPadding = padding.bottom;
        double leftPadding = padding.left;
        double rightPadding = padding.right;
        if (size < breakpoint.minSize) {
          return builder(context, padding.copyWith(left: 0, right: 0));
        } else if (size > breakpoint.maxSize) {
          double remainingWidth = (size - breakpoint.maxSize) / 2;
          leftPadding += remainingWidth;
          rightPadding += remainingWidth;
          leftPadding = max(0, leftPadding);
          rightPadding = max(0, rightPadding);
          return builder(
            context,
            EdgeInsets.only(
              top: topPadding,
              bottom: bottomPadding,
              left: leftPadding,
              right: rightPadding,
            ),
          );
        }
        double minWidth = breakpoint.getMinWidth(size);
        double maxWidth = breakpoint.getMaxWidth(size);
        assert(
          minWidth <= maxWidth,
          'minWidth must be less than or equal to maxWidth ($minWidth > $maxWidth)',
        );
        double remainingWidth = (size - minWidth) / 2;
        leftPadding += remainingWidth;
        rightPadding += remainingWidth;
        leftPadding = max(0, leftPadding);
        rightPadding = max(0, rightPadding);
        return builder(
          context,
          EdgeInsets.only(
            top: topPadding,
            bottom: bottomPadding,
            left: leftPadding,
            right: rightPadding,
          ),
        );
      },
    );
  }
}
