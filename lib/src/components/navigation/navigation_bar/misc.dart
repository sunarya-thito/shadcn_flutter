import 'dart:math' as math;

import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/src/components/layout/hidden.dart';
import 'data.dart';
import 'item.dart';

double startPadding(EdgeInsets padding, Axis direction) {
  if (direction == Axis.vertical) {
    return padding.top;
  }
  return padding.left;
}

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
class NavigationGap extends StatelessWidget implements NavigationBarItem {
  /// Size of the gap in logical pixels.
  final double gap;

  /// Creates a navigation gap.
  ///
  /// Parameters:
  /// - [gap] (double, required): Gap size in logical pixels
  const NavigationGap(this.gap, {super.key});

  @override
  int get selectableCount => 0;

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
class NavigationDivider extends StatelessWidget implements NavigationBarItem {
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
  int get selectableCount => 0;

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
    child = NavigationPadding(child: child);
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

class NavigationLabeled extends StatelessWidget {
  final Widget child;
  final Widget label;
  final NavigationLabelPosition position;
  final double spacing;
  final bool showLabel;
  final NavigationLabelType labelType;
  final Axis direction;
  final bool keepCrossAxisSize;
  final bool keepMainAxisSize;

  const NavigationLabeled({
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
    var animatedSize = Hidden(
      hidden: !showLabel,
      direction: direction,
      curve: Curves.easeInOut,
      duration: kDefaultDuration,
      reverse: position == NavigationLabelPosition.start ||
          position == NavigationLabelPosition.top,
      keepCrossAxisSize:
          (this.direction != direction ? keepCrossAxisSize : keepMainAxisSize),
      keepMainAxisSize:
          (this.direction != direction ? keepMainAxisSize : keepCrossAxisSize),
      child: Padding(
        padding: EdgeInsets.only(
          top: position == NavigationLabelPosition.bottom ? spacing : 0,
          bottom: position == NavigationLabelPosition.top ? spacing : 0,
          left: position == NavigationLabelPosition.end ? spacing : 0,
          right: position == NavigationLabelPosition.start ? spacing : 0,
        ),
        child: label,
      ),
    );
    final content = Flex(
      direction: direction,
      mainAxisSize: MainAxisSize.min,
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
    return AnimatedAlign(
      duration: kDefaultDuration,
      curve: Curves.easeInOut,
      alignment: showLabel
          ? switch (position) {
              NavigationLabelPosition.start => AlignmentDirectional.centerEnd,
              NavigationLabelPosition.end => AlignmentDirectional.centerStart,
              NavigationLabelPosition.top => Alignment.topCenter,
              NavigationLabelPosition.bottom => Alignment.bottomCenter,
            }
          : Alignment.center,
      child: content,
    );
  }
}

/// Internal widget that applies spacing between navigation items.
///
/// Automatically calculates and applies appropriate padding based on
/// navigation direction, item position, and parent spacing configuration.
/// Used internally by navigation components.
class NavigationPadding extends StatelessWidget {
  /// Child widget to wrap with padding.
  final Widget child;

  /// Creates a navigation padding wrapper.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Widget to wrap
  const NavigationPadding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final parentData = Data.maybeOf<NavigationControlData>(context);
    final childData = Data.maybeOf<NavigationChildControlData>(context);
    if (parentData != null && childData != null) {
      final direction = parentData.direction;
      final gap = parentData.spacing / 2;
      final index = childData.index;
      final count = parentData.childCount;
      final isFirst = index == 0;
      final isLast = index == count - 1;
      return Padding(
        padding: direction == Axis.vertical
            ? EdgeInsets.only(top: isFirst ? 0 : gap, bottom: isLast ? 0 : gap)
            : EdgeInsets.only(left: isFirst ? 0 : gap, right: isLast ? 0 : gap),
        child: child,
      );
    }
    return child;
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

/// Non-interactive label widget for navigation sections.
///
/// Displays text headers or section labels within navigation bars or sidebars.
/// Supports different overflow behaviors and can be configured as floating or
/// pinned when used in sidebars.
///
/// Example:
/// ```dart
/// NavigationLabel(
///   child: Text('Main Menu').semiBold(),
///   padding: EdgeInsets.all(8),
/// )
/// ```
class NavigationLabel extends StatelessWidget implements NavigationBarItem {
  /// Content widget to display as the label.
  final Widget child;

  /// Alignment of the label content.
  final AlignmentGeometry? alignment;

  /// Padding around the label.
  final EdgeInsetsGeometry? padding;

  /// How to handle text overflow.
  final NavigationOverflow overflow;

  /// Whether the label floats when scrolling (sidebar only).
  final bool floating;

  /// Whether the label is pinned when scrolling (sidebar only).
  final bool pinned;

  /// Creates a navigation label.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Label content
  /// - [alignment] (AlignmentGeometry?): Content alignment
  /// - [floating] (bool): Floating behavior, defaults to false
  /// - [pinned] (bool): Pinned behavior, defaults to false
  /// - [overflow] (NavigationOverflow): Overflow handling, defaults to clip
  /// - [padding] (EdgeInsetsGeometry?): Label padding
  const NavigationLabel({
    super.key,
    this.alignment,
    this.floating = false,
    this.pinned = false,
    this.overflow = NavigationOverflow.clip,
    this.padding,
    required this.child,
  });

  @override
  int get selectableCount => 0;

  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<NavigationControlData>(context);
    if (data?.containerType == NavigationContainerType.sidebar) {
      return buildSliver(context, data);
    }
    return buildBox(context, data);
  }

  /// Builds the child widget with visibility and overflow handling.
  ///
  /// Wraps the child with [Hidden] widget that responds to expansion state
  /// and applies overflow handling based on the overflow property.
  ///
  /// Parameters:
  /// - [context] (BuildContext, required): Build context
  /// - [data] (NavigationControlData?): Navigation control data
  ///
  /// Returns the wrapped child widget.
  Widget buildChild(BuildContext context, NavigationControlData? data) {
    bool expanded = data?.expanded ?? true;
    return Hidden(
      hidden: !expanded,
      direction: data?.direction ?? Axis.vertical,
      curve: Curves.easeInOut,
      duration: kDefaultDuration,
      child: NavigationPadding(
        child: DefaultTextStyle.merge(
          textAlign: TextAlign.center,
          maxLines: 1,
          child: NavigationChildOverflowHandle(
            overflow: overflow,
            child: child,
          ),
        ),
      ),
    );
  }

  /// Builds the label for box-based navigation containers.
  ///
  /// Creates a centered, padded container with the label text.
  /// Appropriate for use in navigation bars and rails.
  ///
  /// Parameters:
  /// - [context] (BuildContext, required): Build context
  /// - [data] (NavigationControlData?): Navigation control data
  ///
  /// Returns widget for box-based navigation.
  Widget buildBox(BuildContext context, NavigationControlData? data) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityContentPadding = theme.density.baseContentPadding * scaling;
    return DefaultTextStyle.merge(
      textAlign: TextAlign.center,
      child: Container(
        alignment: alignment ?? Alignment.center,
        padding: padding ??
            EdgeInsets.symmetric(horizontal: densityContentPadding * 0.5),
        child: buildChild(context, data).xSmall(),
      ),
    );
  }

  /// Builds the label for sliver-based navigation containers (sidebars).
  ///
  /// Creates a persistent header that can be configured as floating or pinned.
  /// Animates based on expansion state and supports scrolling behaviors.
  ///
  /// Parameters:
  /// - [context] (BuildContext, required): Build context
  /// - [data] (NavigationControlData?): Navigation control data
  ///
  /// Returns sliver widget for sidebar navigation.
  Widget buildSliver(BuildContext context, NavigationControlData? data) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityContentPadding = theme.density.baseContentPadding * scaling;
    final densityContainerPadding =
        theme.density.baseContainerPadding * scaling;
    return AnimatedValueBuilder(
      duration: kDefaultDuration,
      curve: Curves.easeInOut,
      value: (data?.expanded ?? true) ? 1.0 : 0.0,
      child: buildChild(context, data),
      builder: (context, value, child) {
        return SliverPersistentHeader(
          pinned: pinned,
          floating: floating,
          delegate: _NavigationLabelDelegate(
            maxExtent: densityContainerPadding * 3 * value,
            minExtent: densityContainerPadding * 3 * value,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Scrollable.ensureVisible(
                  context,
                  duration: kDefaultDuration,
                  curve: Curves.easeInOut,
                );
              },
              child: Container(
                alignment: alignment ?? AlignmentDirectional.centerStart,
                padding: padding ??
                    EdgeInsets.symmetric(horizontal: densityContentPadding),
                child: child!.semiBold().large(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class NavigationChildOverflowHandle extends StatelessWidget {
  final NavigationOverflow overflow;
  final Widget child;

  const NavigationChildOverflowHandle({
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

class _NavigationLabelDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  @override
  final double maxExtent;
  @override
  final double minExtent;

  _NavigationLabelDelegate({
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
  bool shouldRebuild(covariant _NavigationLabelDelegate oldDelegate) {
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
///   index: 0,
///   child: CustomNavigationItem(),
/// )
///
/// // Builder with selection state
/// NavigationWidget.builder(
///   index: 1,
///   builder: (context, selected) => CustomItem(
///     highlighted: selected,
///   ),
/// )
/// ```
class NavigationWidget extends StatelessWidget implements NavigationBarItem {
  /// Optional index for selection tracking.
  final int? index;

  /// Static child widget.
  final Widget? child;

  /// Builder function that receives selection state.
  final NavigationWidgetBuilder? builder;

  /// Creates a navigation widget with a static child.
  ///
  /// Parameters:
  /// - [index] (int?): Selection index
  /// - [child] (Widget, required): Static child widget
  const NavigationWidget({super.key, this.index, required Widget this.child})
      : builder = null;

  /// Creates a navigation widget with a selection-aware builder.
  ///
  /// Parameters:
  /// - [index] (int?): Selection index
  /// - [builder] (NavigationWidgetBuilder, required): Builder receiving selection state
  const NavigationWidget.builder({
    super.key,
    this.index,
    required NavigationWidgetBuilder this.builder,
  }) : child = null;

  @override
  int get selectableCount => index == null ? 1 : 0;

  @override
  Widget build(BuildContext context) {
    var data = Data.maybeOf<NavigationControlData>(context);
    var childData = Data.maybeOf<NavigationChildControlData>(context);
    var index = childData?.index ?? this.index;
    var isSelected = index == data?.selectedIndex;
    return child ?? builder!(context, isSelected);
  }
}

/// A navigation header/footer item with configurable content.
///
/// Designed for navigation header and footer sections. The layout adapts to
/// the navigation expansion state and keeps a compact density when collapsed.
class NavigationSlotItem extends StatelessWidget {
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

  /// Creates a [NavigationSlotItem].
  const NavigationSlotItem({
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
    final densityGap = theme.density.baseGap * scaling;
    final densityContentPadding = theme.density.baseContentPadding * scaling;
    final defaultPadding = EdgeInsets.symmetric(
      vertical: densityGap,
      horizontal: densityContentPadding * 0.75,
    );
    final expanded = data?.expanded ?? true;
    final style = const ButtonStyle.ghost(
      density: ButtonDensity.icon,
    );
    final navPadding = data?.parentPadding ?? defaultPadding;
    final buttonPadding = style
        .padding(context, const <WidgetState>{}).optionallyResolve(context);
    final slotPadding = EdgeInsets.only(
      left: math.max(0, navPadding.left - buttonPadding.left),
      top: math.max(0, navPadding.top - buttonPadding.top),
      right: math.max(0, navPadding.right - buttonPadding.right),
      bottom: math.max(0, navPadding.bottom - buttonPadding.bottom),
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
        Flexible(
          child: Hidden(
            hidden: !showLabel,
            duration: kDefaultDuration,
            curve: Curves.easeInOut,
            direction: Axis.horizontal,
            child: DefaultTextStyle.merge(
              maxLines: 1,
              overflow: TextOverflow.clip,
              child: Row(
                children: [
                  Gap(densityGap),
                  Expanded(child: titleColumn),
                  if (trailing != null) ...[
                    Gap(densityGap),
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
      alignment: alignment ??
          (data?.containerType == NavigationContainerType.sidebar &&
                  data?.labelDirection == Axis.horizontal &&
                  expanded
              ? (data?.parentLabelPosition == NavigationLabelPosition.start
                  ? AlignmentDirectional.centerEnd
                  : AlignmentDirectional.centerStart)
              : Alignment.center),
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

    return Padding(
      padding: slotPadding,
      child: NavigationPadding(
        child: button,
      ),
    );
  }
}
