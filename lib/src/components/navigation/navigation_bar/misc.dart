import 'dart:math' as math;

import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/src/components/layout/hidden.dart';

/// Returns the padding at the start of the axis.
double startPadding(EdgeInsets padding, Axis direction) {
  if (direction == Axis.vertical) {
    return padding.top;
  }
  return padding.left;
}

/// Returns the padding at the end of the axis.
double endPadding(EdgeInsets padding, Axis direction) {
  if (direction == Axis.vertical) {
    return padding.bottom;
  }
  return padding.right;
}

/// Spacing gap between navigation items.
///
/// Creates empty space in navigation bars or sidebars. Automatically
/// uses appropriate gap type based on container (Gap for boxes, SliverGap for slivers).
class NavigationGap extends StatelessWidget {
  /// Size of the gap in logical pixels.
  final double gap;

  /// Creates a navigation gap.
  ///
  /// Parameters:
  /// - [gap] (double, required): Gap size in logical pixels
  const NavigationGap(this.gap, {super.key});

  /// Builds the gap widget for box-based navigation containers.
  ///
  /// Returns a [Gap] widget with the specified gap size.
  Widget buildBox(BuildContext context) {
    return Gap(gap);
  }

  /// Builds the gap widget for sliver-based navigation containers.
  ///
  /// Returns a [SliverGap] widget with the specified gap size.
  Widget buildSliver(BuildContext context) {
    return SliverGap(gap);
  }

  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<NavigationControlData>(context);
    if (data?.containerType == NavigationContainerType.sidebar) {
      return buildSliver(context);
    }
    return buildBox(context);
  }
}

/// Visual divider between navigation items.
///
/// Renders a horizontal or vertical line separator in navigation bars.
/// Automatically adapts direction based on navigation orientation.
class NavigationDivider extends StatelessWidget {
  /// Optional thickness of the divider line.
  final double? thickness;

  /// Optional color for the divider.
  final Color? color;

  /// Creates a navigation divider.
  ///
  /// Parameters:
  /// - [thickness] (double?): Line thickness
  /// - [color] (Color?): Divider color
  const NavigationDivider({super.key, this.thickness, this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final data = Data.maybeOf<NavigationControlData>(context);
    final parentPadding = data?.parentPadding ?? EdgeInsets.zero;
    final direction = data?.direction ?? Axis.vertical;
    Widget child;
    if (direction == Axis.vertical) {
      child = Divider(
        indent: -parentPadding.left,
        endIndent: -parentPadding.right,
        thickness: thickness ?? (1 * scaling),
        color: color ?? theme.colorScheme.muted,
      );
    } else {
      child = VerticalDivider(
        indent: -parentPadding.top,
        endIndent: -parentPadding.bottom,
        thickness: thickness ?? (1 * scaling),
        color: color ?? theme.colorScheme.muted,
      );
    }
    if (data?.containerType == NavigationContainerType.sidebar) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: direction == Axis.vertical
              ? EdgeInsets.symmetric(vertical: theme.density.baseGap * scaling)
              : EdgeInsets.symmetric(
                  horizontal: theme.density.baseGap * scaling,
                ),
          child: child,
        ),
      );
    }
    return Padding(
      padding: direction == Axis.vertical
          ? EdgeInsets.symmetric(
              vertical: theme.density.baseGap * scaling * 0.5,
            )
          : EdgeInsets.symmetric(
              horizontal: theme.density.baseGap * scaling * 0.5,
            ),
      child: child,
    );
  }
}

/// Internal widget that handles label positioning and expansion animation.
class NavigationLabeled extends StatelessWidget {
  /// The main content widget.
  final Widget child;

  /// The label widget.
  final Widget label;

  /// Where to position the label relative to the child.
  final NavigationLabelPosition position;

  /// Spacing between label and child.
  final double spacing;

  /// Whether to show the label.
  final bool showLabel;

  /// Type of label presentation.
  final NavigationLabelType labelType;

  /// Layout direction of the navigation.
  final Axis direction;

  /// Whether to maintain cross axis size when hidden.
  final bool keepCrossAxisSize;

  /// Whether to maintain main axis size when hidden.
  final bool keepMainAxisSize;

  /// Creates a [NavigationLabeled].
  const NavigationLabeled({
    super.key,
    required this.child,
    required this.label,
    required this.spacing,
    required this.position,
    required this.showLabel,
    required this.labelType,
    required this.direction,
    required this.keepCrossAxisSize,
    required this.keepMainAxisSize,
  });

  @override
  Widget build(BuildContext context) {
    var direction = position == NavigationLabelPosition.top ||
            position == NavigationLabelPosition.bottom
        ? Axis.vertical
        : Axis.horizontal;
    var animatedSize = Flexible(
      child: Hidden(
        hidden: !showLabel,
        direction: direction,
        duration: kDefaultDuration,
        reverse: position == NavigationLabelPosition.start ||
            position == NavigationLabelPosition.top,
        keepCrossAxisSize: (this.direction != direction
            ? keepCrossAxisSize
            : keepMainAxisSize),
        keepMainAxisSize: (this.direction != direction
            ? keepMainAxisSize
            : keepCrossAxisSize),
        child: Padding(
          padding: EdgeInsets.only(
            top: position == NavigationLabelPosition.bottom ? spacing : 0,
            bottom: position == NavigationLabelPosition.top ? spacing : 0,
            left: position == NavigationLabelPosition.end ? spacing : 0,
            right: position == NavigationLabelPosition.start ? spacing : 0,
          ),
          child: Align(
              alignment: switch (position) {
                NavigationLabelPosition.top => Alignment.bottomCenter,
                NavigationLabelPosition.bottom => Alignment.topCenter,
                NavigationLabelPosition.start => AlignmentDirectional.centerEnd,
                NavigationLabelPosition.end => AlignmentDirectional.centerStart,
              },
              child: label),
        ),
      ),
    );
    final content = Flex(
      direction: direction,
      mainAxisSize: MainAxisSize.min,
      // we don't use spacing here because we want to animate the size of the label
      children: [
        if (position == NavigationLabelPosition.start ||
            position == NavigationLabelPosition.top)
          animatedSize,
        child,
        if (position == NavigationLabelPosition.end ||
            position == NavigationLabelPosition.bottom)
          animatedSize,
      ],
    );
    return content;
  }
}

/// Overflow behavior for navigation item labels.
enum NavigationOverflow {
  /// Clip text that exceeds bounds
  clip,

  /// Scroll text horizontally when too long
  marquee,

  /// Show ellipsis (...) for overflow
  ellipsis,

  /// No overflow handling
  none,
}

/// Multi-purpose navigation group that organizes children with a label.
///
/// Replaces the standalone `NavigationLabel`. In sidebars, it organizes
/// items into a scrollable group using `SliverMainAxisGroup`, optionally
/// with a floating or pinned label header.
class NavigationGroup extends StatelessWidget {
  /// Label widget to display for the group.
  final Widget label;

  /// The child items within this group.
  final List<Widget> children;

  /// Position of the label relative to the children.
  final NavigationLabelPosition labelPosition;

  /// Alignment of the label content.
  final AlignmentGeometry? labelAlignment;

  /// Padding around the label.
  final EdgeInsetsGeometry? labelPadding;

  /// How to handle label text overflow.
  final NavigationOverflow labelOverflow;

  /// Whether the label floats when scrolling (sidebar only).
  final bool labelFloating;

  /// Whether the label is pinned when scrolling (sidebar only).
  final bool labelPinned;

  /// Creates a new navigation group.
  const NavigationGroup({
    super.key,
    required this.label,
    this.children = const [],
    this.labelPosition = NavigationLabelPosition.top,
    this.labelAlignment,
    this.labelPadding,
    this.labelOverflow = NavigationOverflow.clip,
    this.labelFloating = false,
    this.labelPinned = false,
  });

  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<NavigationControlData>(context);
    if (data?.containerType == NavigationContainerType.sidebar) {
      return buildSliver(context, data);
    }
    return buildBox(context, data);
  }

  /// Builds the label content with appropriate styles and expansion handling.
  Widget buildLabelChild(BuildContext context, NavigationControlData? data) {
    bool expanded = data?.expanded ?? true;
    return Hidden(
      hidden: !expanded,
      direction: data?.direction ?? Axis.vertical,
      reverse: true,
      duration: kDefaultDuration,
      child: DefaultTextStyle.merge(
        textAlign: TextAlign.center,
        maxLines: 1,
        child: NavigationChildOverflowHandle(
          overflow: labelOverflow,
          child: label,
        ),
      ),
    );
  }

  /// Builds a column with the label and children. (Non-sidebar context)
  Widget buildBox(BuildContext context, NavigationControlData? data) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityContentPadding = theme.density.baseContentPadding * scaling;

    final labelWidget = buildLabelChild(context, data);
    final paddedLabel = Container(
      alignment: labelAlignment ?? Alignment.center,
      padding: labelPadding ??
          EdgeInsets.symmetric(horizontal: densityContentPadding * padXs),
      child: labelWidget,
    );
    final gap = theme.density.baseGap * scaling * gapSm;

    final items = children;

    final childControlData = data == null
        ? null
        : NavigationControlData(
            containerType: data.containerType,
            parentLabelType: data.parentLabelType,
            parentLabelPosition: data.parentLabelPosition,
            parentLabelSize: data.parentLabelSize,
            parentPadding: data.parentPadding,
            direction: data.direction,
            selectedKey: data.selectedKey,
            onSelected: data.onSelected,
            expanded: data.expanded,
            childCount: items.length,
            spacing: data.spacing,
            keepCrossAxisSize: data.keepCrossAxisSize,
            keepMainAxisSize: data.keepMainAxisSize,
          );

    final flexChildren = [
      if (labelPosition == NavigationLabelPosition.top ||
          labelPosition == NavigationLabelPosition.start) ...[
        paddedLabel,
        AnimatedValueBuilder<double>(
          value: data?.expanded == true ? gap : 0,
          builder: (_, gap, __) => Gap(gap),
          duration: kDefaultDuration,
          // curve: Curves.easeInOut,
        ),
      ],
      Data.inherit(
        data: childControlData,
        child: Flex(
          direction: data?.direction ?? Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: data?.spacing ?? 0,
          children: items,
        ),
      ),
      if (labelPosition == NavigationLabelPosition.bottom ||
          labelPosition == NavigationLabelPosition.end) ...[
        AnimatedValueBuilder<double>(
          value: data?.expanded == true ? gap : 0,
          builder: (_, gap, __) => Gap(gap),
          duration: kDefaultDuration,
          // curve: Curves.easeInOut,
        ),
        paddedLabel,
      ],
    ];

    return Flex(
      direction: data?.direction ?? Axis.vertical,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: flexChildren,
    );
  }

  /// Builds a SliverMainAxisGroup containing the label and children. (Sidebar/Sliver context)
  Widget buildSliver(BuildContext context, NavigationControlData? data) {
    return SliverToBoxAdapter(child: buildBox(context, data));
  }
}

/// Internal widget that handles label overflow based on [NavigationOverflow].
class NavigationChildOverflowHandle extends StatelessWidget {
  /// How to handle overflow.
  final NavigationOverflow overflow;

  /// The content that might overflow.
  final Widget child;

  /// Creates a [NavigationChildOverflowHandle].
  const NavigationChildOverflowHandle({
    super.key,
    required this.overflow,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    switch (overflow) {
      case NavigationOverflow.clip:
        return ClipRect(child: child);
      case NavigationOverflow.marquee:
        return OverflowMarquee(child: child);
      case NavigationOverflow.ellipsis:
        return DefaultTextStyle.merge(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          child: child,
        );
      case NavigationOverflow.none:
        return child;
    }
  }
}

class _NavigationGroupLabelDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  @override
  final double maxExtent;
  @override
  final double minExtent;

  _NavigationGroupLabelDelegate({
    required this.maxExtent,
    required this.minExtent,
    required this.child,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final theme = Theme.of(context);
    final data = Data.maybeOf<NavigationControlData>(context);
    final parentPadding = data?.parentPadding ?? EdgeInsets.zero;
    final direction = data?.direction ?? Axis.vertical;
    final color = theme.colorScheme.background;
    return CustomPaint(
      painter: _NavigationLabelBackgroundPainter(
        color: color,
        indent: -startPadding(parentPadding, direction),
        endIndent: -endPadding(parentPadding, direction),
        direction: direction,
      ),
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant _NavigationGroupLabelDelegate oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.maxExtent != maxExtent ||
        oldDelegate.minExtent != minExtent;
  }
}

class _NavigationLabelBackgroundPainter extends CustomPainter {
  final Color color;
  final double indent;
  final double endIndent;
  final Axis direction;

  _NavigationLabelBackgroundPainter({
    required this.color,
    required this.indent,
    required this.endIndent,
    required this.direction,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    // indent and endIndent is direction dependent
    if (direction == Axis.vertical) {
      canvas.drawRect(
        Rect.fromLTWH(indent, 0, size.width - indent - endIndent, size.height),
        paint,
      );
    } else {
      canvas.drawRect(
        Rect.fromLTWH(0, indent, size.width, size.height - indent - endIndent),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _NavigationLabelBackgroundPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.indent != indent ||
        oldDelegate.endIndent != endIndent ||
        oldDelegate.direction != direction;
  }
}

/// Builder function for navigation widgets with selection state.
///
/// Parameters:
/// - [context] (BuildContext): Build context
/// - [selected] (bool): Whether this item is currently selected
///
/// Returns a widget that adapts to selection state.
typedef NavigationWidgetBuilder = Widget Function(
    BuildContext context, bool selected);

/// Custom widget wrapper for navigation items.
///
/// Allows inserting custom widgets into navigation containers with optional
/// selection tracking. Can be used with a static child or a builder that
/// responds to selection state.
///
/// Example:
/// ```dart
/// // Static widget
/// NavigationWidget(
///   key: ValueKey('custom'),
///   child: CustomNavigationItem(),
/// )
///
/// // Builder with selection state
/// NavigationWidget.builder(
///   key: ValueKey('custom_builder'),
///   builder: (context, selected) => CustomItem(
///     highlighted: selected,
///   ),
/// )
/// ```
class NavigationWidget extends StatelessWidget {
  /// Static child widget.
  final Widget? child;

  /// Builder function that receives selection state.
  final NavigationWidgetBuilder? builder;

  /// Creates a navigation widget with a static child.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Static child widget
  const NavigationWidget({super.key, required Widget this.child})
      : builder = null;

  /// Creates a navigation widget with a selection-aware builder.
  ///
  /// Parameters:
  /// - [builder] (NavigationWidgetBuilder, required): Builder receiving selection state
  const NavigationWidget.builder({
    super.key,
    required NavigationWidgetBuilder this.builder,
  }) : child = null;

  @override
  Widget build(BuildContext context) {
    var data = Data.maybeOf<NavigationControlData>(context);
    var key = this.key;
    var isSelected = key != null && key == data?.selectedKey;
    return child ?? builder!(context, isSelected);
  }
}

/// A navigation header/footer item with configurable content.
///
/// Designed for navigation header and footer sections. The layout adapts to
/// the navigation expansion state and keeps a compact density when collapsed.
class NavigationSlot extends StatelessWidget {
  /// Leading widget (usually an icon or avatar).
  final Widget leading;

  /// Primary title widget.
  final Widget title;

  /// Optional subtitle widget shown under the title.
  final Widget? subtitle;

  /// Optional trailing widget (often a chevron or action icon).
  final Widget? trailing;

  /// Gap multiplier between the text block and trailing widget.
  final double? trailingGap;

  /// Callback for press interactions.
  final VoidCallback? onPressed;

  /// Alignment for the button content.
  final AlignmentGeometry? alignment;

  /// Creates a [NavigationSlot].
  const NavigationSlot({
    super.key,
    required this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.trailingGap,
    this.onPressed,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<NavigationControlData>(context);
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    double densityGap = theme.density.baseGap * scaling;
    final expanded = data?.expanded ?? true;
    final style = (expanded
            ? ButtonStyle.ghost(
                density: ButtonDensity.compact,
              )
            : ButtonStyle.text(density: ButtonDensity.compact))
        .copyWith(
      margin: (context, state, margin) =>
          -EdgeInsetsDensity.all(expanded ? padXs : 0)
              .resolveDensity(theme.density.baseContainerPadding * scaling),
    );
    final titleColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        if (subtitle != null) subtitle!,
      ],
    );

    final showLabel = data == null ||
        data.parentLabelType == NavigationLabelType.all ||
        (data.parentLabelType == NavigationLabelType.expanded && expanded);

    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        leading,
        AnimatedValueBuilder<double>(
          value: showLabel ? densityGap : 0,
          builder: (_, gap, __) => Gap(gap),
          duration: kDefaultDuration,
          // curve: Curves.easeInOut,
        ),
        Flexible(
          child: Hidden(
            hidden: !showLabel,
            duration: kDefaultDuration,
            direction: Axis.horizontal,
            child: DefaultTextStyle.merge(
              maxLines: 1,
              overflow: TextOverflow.clip,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(child: titleColumn),
                  if (trailing != null) ...[
                    AnimatedValueBuilder<double>(
                      value: showLabel ? (trailingGap ?? densityGap) : 0,
                      builder: (_, gap, __) => Gap(gap),
                      duration: kDefaultDuration,
                      // curve: Curves.easeInOut,
                    ),
                    trailing!,
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );

    Widget button = Button(
      onPressed: onPressed,
      style: style,
      child: content,
    );

    if (data?.parentLabelType == NavigationLabelType.tooltip) {
      if (title is! SizedBox) {
        AlignmentGeometry alignment = Alignment.topCenter;
        AlignmentGeometry anchorAlignment = Alignment.bottomCenter;
        if (data?.direction == Axis.vertical) {
          alignment = AlignmentDirectional.centerStart;
          anchorAlignment = AlignmentDirectional.centerEnd;
        }
        button = Tooltip(
          waitDuration: !isMobile(theme.platform)
              ? Duration.zero
              : const Duration(milliseconds: 500),
          alignment: alignment,
          anchorAlignment: anchorAlignment,
          tooltip: TooltipContainer(child: title).call,
          child: button,
        );
      }
    }

    return button;
  }
}
