import 'dart:math';


import '../../../shadcn_flutter.dart';

abstract class StageBreakpoint {
  factory StageBreakpoint.constant(
    double breakpoint, {
    double minSize = 0,
    double maxSize = double.infinity,
  }) {
    return ConstantBreakpoint(breakpoint, minSize: minSize, maxSize: maxSize);
  }

  factory StageBreakpoint.staged(List<double> breakpoints) {
    return StagedBreakpoint(breakpoints);
  }

  static const StageBreakpoint defaultBreakpoints =
      StagedBreakpoint.defaultBreakpoints();

  double getMinWidth(double width);
  double getMaxWidth(double width);
  double get minSize;
  double get maxSize;
}

class ConstantBreakpoint implements StageBreakpoint {
  final double breakpoint;
  @override
  final double minSize;
  @override
  final double maxSize;

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

class StagedBreakpoint implements StageBreakpoint {
  static const List<double> _defaultBreakpoints = [576, 768, 992, 1200, 1400];
  final List<double> breakpoints;

  const StagedBreakpoint(this.breakpoints) : assert(breakpoints.length > 1);
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

class StageContainerTheme {
  final StageBreakpoint? breakpoint;
  final EdgeInsets? padding;

  const StageContainerTheme({this.breakpoint, this.padding});

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

class StageContainer extends StatelessWidget {
  final StageBreakpoint breakpoint;
  final Widget Function(BuildContext context, EdgeInsets padding) builder;
  final EdgeInsets padding;

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
