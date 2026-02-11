import 'dart:math' as math;

import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/src/components/layout/hidden.dart';
import 'data.dart';
import 'theme.dart';
import 'mixin.dart';
import 'misc.dart';

/// A vertical or horizontal navigation rail component for sidebar navigation.
///
/// Provides a compact navigation interface typically used in sidebar layouts
/// or as a secondary navigation element. The rail displays navigation items
/// in a linear arrangement with configurable alignment, spacing, and label
/// presentation. Items can show icons, labels, or both based on configuration.
///
/// The rail supports both vertical and horizontal orientations, making it
/// suitable for various layout contexts including left/right sidebars,
/// top/bottom navigation bars, or embedded navigation within content areas.
/// Label presentation can be customized to show always, on selection, or never.
///
/// Integrates with the navigation theming system and supports background
/// customization, surface effects, and responsive sizing based on content
/// and constraints.
///
/// Example:
/// ```dart
/// NavigationRail(
///   direction: Axis.vertical,
///   alignment: NavigationRailAlignment.start,
///   labelType: NavigationLabelType.all,
///   index: selectedIndex,
///   onSelected: (index) => setState(() => selectedIndex = index),
///   children: [
///     NavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
///     NavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
///     NavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
///   ],
/// )
/// ```
class NavigationRail extends StatefulWidget {
  /// Background color for the navigation rail surface.
  ///
  /// When null, uses the theme's default surface color. The background
  /// provides visual separation from surrounding content and establishes
  /// the rail as a distinct navigation area.
  final Color? backgroundColor;

  /// List of navigation items to display in the rail.
  ///
  /// Each item should be a [NavigationBarItem] that defines the icon,
  /// label, and optional badge for a navigation destination. Items are
  /// arranged according to the specified direction and alignment.
  final List<Widget> children;

  /// Optional fixed header items displayed before the scrollable content.
  final List<Widget>? header;

  /// Optional fixed footer items displayed after the scrollable content.
  final List<Widget>? footer;

  /// Alignment of items within the rail's main axis.
  ///
  /// Controls how navigation items are distributed along the rail's
  /// primary direction (vertical or horizontal). Options include
  /// start, center, and end alignment.
  final NavigationRailAlignment alignment;

  /// Primary layout direction for the navigation rail.
  ///
  /// Determines whether items are arranged vertically (sidebar style)
  /// or horizontally (toolbar style). Affects item spacing and label positioning.
  final Axis direction;

  /// Spacing between navigation items.
  ///
  /// Controls the gap between adjacent navigation items. When null,
  /// uses theme-appropriate default spacing based on direction and size.
  final double? spacing;

  /// Label display behavior for navigation items.
  ///
  /// Controls when and how labels are shown: always visible, only for
  /// selected items, or never displayed. Affects the rail's width and
  /// visual density.
  final NavigationLabelType labelType;

  /// Position of labels relative to icons.
  ///
  /// Determines whether labels appear below, above, or beside icons.
  /// The positioning adapts based on the rail's direction and available space.
  final NavigationLabelPosition labelPosition;

  /// Size variant for label text and overall item dimensions.
  ///
  /// Controls the scale of text and spacing within navigation items.
  /// Smaller sizes create more compact navigation, while larger sizes
  /// improve accessibility and visual prominence.
  final NavigationLabelSize labelSize;

  /// Internal padding applied within the navigation rail.
  ///
  /// Provides space around the navigation items, creating visual breathing
  /// room and preventing items from touching the rail's edges.
  final EdgeInsetsGeometry? padding;

  /// Size constraints for the navigation rail container.
  ///
  /// Defines minimum and maximum width/height bounds for the rail.
  /// Useful for responsive layouts and ensuring consistent sizing.
  final BoxConstraints? constraints;

  /// Cross-axis size when the navigation rail is expanded.
  ///
  /// For vertical rails, this sets the width. For horizontal rails, this sets
  /// the height.
  final double? expandedSize;

  /// Cross-axis size when the navigation rail is collapsed.
  ///
  /// For vertical rails, this sets the width. For horizontal rails, this sets
  /// the height.
  final double? collapsedSize;

  /// Opacity level for surface background effects.
  ///
  /// Controls transparency of background blur and overlay effects.
  /// Values range from 0.0 (transparent) to 1.0 (opaque).
  final double? surfaceOpacity;

  /// Blur intensity for surface background effects.
  ///
  /// Controls the backdrop blur effect behind the navigation rail.
  /// Higher values create more pronounced blur effects.
  final double? surfaceBlur;

  /// Whether the rail should expand to fill available space.
  ///
  /// When true, the rail attempts to use all available space in its
  /// cross-axis direction. When false, the rail sizes itself to content.
  final bool expanded;

  /// Whether to maintain intrinsic size along the main axis.
  ///
  /// Controls how the rail handles sizing when its main axis dimension
  /// is unconstrained. Affects layout behavior in flexible containers.
  final bool keepMainAxisSize;

  /// Whether to maintain intrinsic size along the cross axis.
  ///
  /// Controls how the rail handles sizing when its cross axis dimension
  /// is unconstrained. Useful for preventing unwanted expansion.
  final bool keepCrossAxisSize;

  /// Creates a [NavigationRail] with the specified configuration and items.
  ///
  /// The [children] parameter is required and should contain [NavigationBarItem]
  /// widgets that define the navigation destinations. Other parameters control
  /// the rail's appearance, behavior, and layout characteristics.
  ///
  /// Default values provide a sensible vertical rail configuration suitable
  /// for most sidebar navigation scenarios. Customization allows adaptation
  /// to specific layout requirements and design systems.
  ///
  /// Parameters:
  /// - [children] (`List<NavigationBarItem>`, required): Navigation destinations
  /// - [alignment] (NavigationRailAlignment, default: center): Item alignment along main axis
  /// - [direction] (Axis, default: vertical): Layout orientation of the rail
  /// - [labelType] (NavigationLabelType, default: selected): When to show labels
  /// - [labelPosition] (NavigationLabelPosition, default: bottom): Label positioning
  /// - [index] (int?, optional): Currently selected item index
  /// - [onSelected] (`ValueChanged<int>?`, optional): Selection change callback
  ///
  /// Example:
  /// ```dart
  /// NavigationRail(
  ///   alignment: NavigationRailAlignment.start,
  ///   labelType: NavigationLabelType.all,
  ///   index: currentIndex,
  ///   onSelected: (index) => _navigate(index),
  ///   children: navigationItems,
  /// )
  /// ```
  const NavigationRail({
    super.key,
    this.backgroundColor,
    this.alignment = NavigationRailAlignment.center,
    this.direction = Axis.vertical,
    this.spacing,
    this.labelType = NavigationLabelType.selected,
    this.labelPosition = NavigationLabelPosition.bottom,
    this.labelSize = NavigationLabelSize.small,
    this.padding,
    this.constraints,
    this.expandedSize,
    this.collapsedSize,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.expanded = true,
    this.keepMainAxisSize = false,
    this.keepCrossAxisSize = false,
    this.header,
    this.footer,
    required this.children,
  });

  @override
  State<NavigationRail> createState() => _NavigationRailState();
}

class _NavigationRailState extends State<NavigationRail>
    with NavigationContainerMixin {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityGap = theme.density.baseGap * scaling;
    final densityContentPadding = theme.density.baseContentPadding * scaling;
    var parentPadding = widget.padding ??
        EdgeInsets.symmetric(
          vertical: densityGap,
          horizontal: densityContentPadding * 0.75,
        );
    var directionality = Directionality.of(context);
    var resolvedPadding = parentPadding.resolve(directionality);
    final headerItems = widget.header ?? const <NavigationBarItem>[];
    final footerItems = widget.footer ?? const <NavigationBarItem>[];

    final baseData = NavigationControlData(
      containerType: NavigationContainerType.rail,
      parentLabelType: widget.labelType,
      parentLabelPosition: widget.labelPosition,
      parentLabelSize: widget.labelSize,
      parentPadding: resolvedPadding,
      direction: widget.direction,
      expanded: widget.expanded,
      childCount: widget.children.length,
      spacing: widget.spacing ?? densityGap,
      keepCrossAxisSize: widget.keepCrossAxisSize,
      keepMainAxisSize: widget.keepMainAxisSize,
    );

    Widget buildSection(List<Widget> items, EdgeInsets sectionPadding) {
      if (items.isEmpty) {
        return const SizedBox.shrink();
      }
      return Data.inherit(
        data: NavigationControlData(
          containerType: baseData.containerType,
          parentLabelType: baseData.parentLabelType,
          parentLabelPosition: baseData.parentLabelPosition,
          parentLabelSize: baseData.parentLabelSize,
          parentPadding: baseData.parentPadding,
          direction: baseData.direction,
          selectedIndex: baseData.selectedIndex,
          onSelected: baseData.onSelected,
          expanded: baseData.expanded,
          childCount: items.length,
          spacing: baseData.spacing,
          keepCrossAxisSize: baseData.keepCrossAxisSize,
          keepMainAxisSize: baseData.keepMainAxisSize,
        ),
        child: SingleChildScrollView(
          scrollDirection: widget.direction,
          physics: const NeverScrollableScrollPhysics(),
          padding: sectionPadding,
          child: _wrapIntrinsic(
            Flex(
              direction: widget.direction,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: items,
            ),
          ),
        ),
      );
    }

    Widget rail = RepaintBoundary(
      child: Data.inherit(
        data: baseData,
        child: SurfaceBlur(
          surfaceBlur: widget.surfaceBlur,
          child: Container(
            color: widget.backgroundColor ??
                (theme.colorScheme.background.scaleAlpha(
                  widget.surfaceOpacity ?? 1,
                )),
            padding: headerItems.isNotEmpty || footerItems.isNotEmpty
                ? resolvedPadding.copyWith(
                    left: 0,
                    right: 0,
                  )
                : null,
            child: AnimatedSize(
              duration: kDefaultDuration,
              curve: Curves.easeInOut,
              child: Flex(
                direction: widget.direction,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: baseData.spacing,
                children: [
                  if (headerItems.isNotEmpty)
                    SizedBox(
                      width:
                          widget.direction == Axis.vertical && widget.expanded
                              ? double.infinity
                              : null,
                      height:
                          widget.direction == Axis.horizontal && widget.expanded
                              ? double.infinity
                              : null,
                      child: buildSection(headerItems, EdgeInsets.zero),
                    ),
                  Expanded(
                    child: AnimatedAlign(
                      duration: kDefaultDuration,
                      curve: Curves.easeInOut,
                      alignment: switch ((widget.direction, widget.alignment)) {
                        (Axis.horizontal, NavigationRailAlignment.start) =>
                          AlignmentDirectional.centerStart,
                        (Axis.horizontal, NavigationRailAlignment.center) =>
                          Alignment.center,
                        (Axis.horizontal, NavigationRailAlignment.end) =>
                          AlignmentDirectional.centerEnd,
                        (Axis.vertical, NavigationRailAlignment.start) =>
                          AlignmentDirectional.topCenter,
                        (Axis.vertical, NavigationRailAlignment.center) =>
                          Alignment.center,
                        (Axis.vertical, NavigationRailAlignment.end) =>
                          AlignmentDirectional.bottomCenter,
                      },
                      widthFactor:
                          widget.direction == Axis.horizontal ? 1 : null,
                      heightFactor:
                          widget.direction == Axis.vertical ? 1 : null,
                      child: SizedBox(
                        width:
                            widget.direction == Axis.vertical && widget.expanded
                                ? double.infinity
                                : null,
                        height: widget.direction == Axis.horizontal &&
                                widget.expanded
                            ? double.infinity
                            : null,
                        child: SingleChildScrollView(
                          scrollDirection: widget.direction,
                          padding:
                              headerItems.isNotEmpty || footerItems.isNotEmpty
                                  ? resolvedPadding.copyWith(
                                      top: 0,
                                      bottom: 0,
                                    )
                                  : resolvedPadding,
                          child: Flex(
                            direction: widget.direction,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            spacing: baseData.spacing,
                            children: widget.children,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (footerItems.isNotEmpty)
                    SizedBox(
                      width:
                          widget.direction == Axis.vertical && widget.expanded
                              ? double.infinity
                              : null,
                      height:
                          widget.direction == Axis.horizontal && widget.expanded
                              ? double.infinity
                              : null,
                      child: buildSection(footerItems, EdgeInsets.zero),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    if (widget.constraints != null) {
      rail = ConstrainedBox(constraints: widget.constraints!, child: rail);
    }
    if (widget.expandedSize != null || widget.collapsedSize != null) {
      final targetMinSize = widget.expanded
          ? (widget.expandedSize ?? 0.0)
          : (widget.collapsedSize ?? 0.0);
      final maxSize = widget.expandedSize ?? double.infinity;
      rail = AnimatedValueBuilder<double>(
        value: targetMinSize,
        duration: kDefaultDuration,
        curve: Curves.easeInOut,
        builder: (context, animatedMinSize, child) {
          return ConstrainedBox(
            constraints: widget.direction == Axis.vertical
                ? BoxConstraints(minWidth: animatedMinSize, maxWidth: maxSize)
                : BoxConstraints(
                    minHeight: animatedMinSize, maxHeight: maxSize),
            child: child,
          );
        },
        child: rail,
      );
    }
    return _wrapIntrinsic(rail);
  }

  Widget _wrapIntrinsic(Widget child) {
    if (widget.direction == Axis.horizontal) {
      return IntrinsicHeight(child: child);
    }
    return IntrinsicWidth(child: child);
  }
}

