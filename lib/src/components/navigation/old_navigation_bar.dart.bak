import 'dart:math' as math;

import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/src/components/layout/hidden.dart';

/// Enumeration defining alignment options for navigation bar items.
///
/// This enum provides various alignment strategies for positioning navigation
/// items within the available space, corresponding to Flutter's MainAxisAlignment
/// options but specifically tailored for navigation contexts.
enum NavigationBarAlignment {
  /// Align items to the start of the navigation bar.
  start(MainAxisAlignment.start),

  /// Center items within the navigation bar.
  center(MainAxisAlignment.center),

  /// Align items to the end of the navigation bar.
  end(MainAxisAlignment.end),

  /// Distribute items with space between them.
  spaceBetween(MainAxisAlignment.spaceBetween),

  /// Distribute items with space around them.
  spaceAround(MainAxisAlignment.spaceAround),

  /// Distribute items with equal space between and around them.
  spaceEvenly(MainAxisAlignment.spaceEvenly);

  /// The corresponding MainAxisAlignment value.
  final MainAxisAlignment mainAxisAlignment;

  /// Creates a NavigationBarAlignment with the associated MainAxisAlignment.
  const NavigationBarAlignment(this.mainAxisAlignment);
}

/// Enumeration defining alignment options for navigation rail items.
///
/// This enum provides alignment strategies specifically for navigation rails,
/// which are typically vertical navigation components.
enum NavigationRailAlignment {
  /// Align items to the start (top) of the rail.
  start,

  /// Center items within the rail.
  center,

  /// Align items to the end (bottom) of the rail.
  end
}

/// Enumeration defining the type of navigation container.
///
/// This enum identifies the different navigation layout modes available,
/// each with distinct visual presentations and interaction patterns.
enum NavigationContainerType {
  /// Vertical rail navigation, typically positioned at the side.
  rail,

  /// Horizontal bar navigation, typically positioned at the top or bottom.
  bar,

  /// Expandable sidebar navigation with more space for content.
  sidebar
}

/// Theme data for customizing [NavigationBar] widget appearance.
///
/// This class defines the visual and behavioral properties that can be applied to
/// [NavigationBar] widgets, including background colors, alignment, spacing,
/// label presentation, and padding. These properties can be set at the theme level
/// to provide consistent styling across the application.
class NavigationBarTheme extends ComponentThemeData {
  /// Background color of the navigation bar.
  final Color? backgroundColor;

  /// Alignment of navigation items.
  final NavigationBarAlignment? alignment;

  /// Layout direction (horizontal or vertical).
  final Axis? direction;

  /// Spacing between navigation items.
  final double? spacing;

  /// Type of label display (e.g., always show, hide, etc.).
  final NavigationLabelType? labelType;

  /// Position of labels relative to icons.
  final NavigationLabelPosition? labelPosition;

  /// Size variant for labels.
  final NavigationLabelSize? labelSize;

  /// Internal padding of the navigation bar.
  final EdgeInsetsGeometry? padding;

  /// Creates a [NavigationBarTheme].
  ///
  /// Parameters:
  /// - [backgroundColor] (`Color?`, optional): Background color.
  /// - [alignment] (`NavigationBarAlignment?`, optional): Item alignment.
  /// - [direction] (`Axis?`, optional): Layout direction.
  /// - [spacing] (`double?`, optional): Item spacing.
  /// - [labelType] (`NavigationLabelType?`, optional): Label display type.
  /// - [labelPosition] (`NavigationLabelPosition?`, optional): Label position.
  /// - [labelSize] (`NavigationLabelSize?`, optional): Label size.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): Internal padding.
  const NavigationBarTheme({
    this.backgroundColor,
    this.alignment,
    this.direction,
    this.spacing,
    this.labelType,
    this.labelPosition,
    this.labelSize,
    this.padding,
  });

  /// Creates a copy of this theme with the given fields replaced.
  ///
  /// Parameters:
  /// - [backgroundColor] (`ValueGetter<Color?>?`, optional): New background color.
  /// - [alignment] (`ValueGetter<NavigationBarAlignment?>?`, optional): New alignment.
  /// - [direction] (`ValueGetter<Axis?>?`, optional): New direction.
  /// - [spacing] (`ValueGetter<double?>?`, optional): New spacing.
  /// - [labelType] (`ValueGetter<NavigationLabelType?>?`, optional): New label type.
  /// - [labelPosition] (`ValueGetter<NavigationLabelPosition?>?`, optional): New label position.
  /// - [labelSize] (`ValueGetter<NavigationLabelSize?>?`, optional): New label size.
  /// - [padding] (`ValueGetter<EdgeInsetsGeometry?>?`, optional): New padding.
  ///
  /// Returns: A new [NavigationBarTheme] with updated properties.
  NavigationBarTheme copyWith({
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<NavigationBarAlignment?>? alignment,
    ValueGetter<Axis?>? direction,
    ValueGetter<double?>? spacing,
    ValueGetter<NavigationLabelType?>? labelType,
    ValueGetter<NavigationLabelPosition?>? labelPosition,
    ValueGetter<NavigationLabelSize?>? labelSize,
    ValueGetter<EdgeInsetsGeometry?>? padding,
  }) {
    return NavigationBarTheme(
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
      alignment: alignment == null ? this.alignment : alignment(),
      direction: direction == null ? this.direction : direction(),
      spacing: spacing == null ? this.spacing : spacing(),
      labelType: labelType == null ? this.labelType : labelType(),
      labelPosition:
          labelPosition == null ? this.labelPosition : labelPosition(),
      labelSize: labelSize == null ? this.labelSize : labelSize(),
      padding: padding == null ? this.padding : padding(),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is NavigationBarTheme &&
        other.backgroundColor == backgroundColor &&
        other.alignment == alignment &&
        other.direction == direction &&
        other.spacing == spacing &&
        other.labelType == labelType &&
        other.labelPosition == labelPosition &&
        other.labelSize == labelSize &&
        other.padding == padding;
  }

  @override
  int get hashCode => Object.hash(
        backgroundColor,
        alignment,
        direction,
        spacing,
        labelType,
        labelPosition,
        labelSize,
        padding,
      );
}

/// Base class for navigation bar items.
///
/// Abstract widget class that all navigation items must extend.
/// Provides common interface for items within [NavigationBar].
abstract class NavigationBarItem extends Widget {
  /// Creates a [NavigationBarItem].
  const NavigationBarItem({super.key});

  /// Number of selectable items represented by this item.
  int get selectableCount;
}

/// A flexible navigation container widget for organizing navigation items.
///
/// [NavigationBar] provides a comprehensive navigation solution that can be configured
/// for various layouts including horizontal bars, vertical rails, and expandable sidebars.
/// It manages navigation item presentation, selection states, and provides extensive
/// customization options for different navigation patterns.
///
/// Key features:
/// - Flexible layout orientation (horizontal/vertical)
/// - Multiple alignment strategies for item positioning
/// - Configurable label presentation and positioning
/// - Selection state management with callbacks
/// - Surface effects for glassmorphism styling
/// - Responsive behavior with expansion options
/// - Theme integration for consistent styling
/// - Support for gaps, dividers, and custom widgets
///
/// Navigation layout modes:
/// - Bar mode: Horizontal layout for top/bottom navigation
/// - Rail mode: Vertical compact layout for side navigation
/// - Sidebar mode: Expanded vertical layout with more content space
///
/// Item organization features:
/// - Automatic selection state management
/// - Customizable spacing between items
/// - Support for navigation gaps and dividers
/// - Flexible item alignment options
/// - Label display controls (always, never, selected)
///
/// The widget supports various navigation patterns:
/// - Tab-style navigation with selection highlighting
/// - Menu-style navigation with hover states
/// - Hierarchical navigation with grouping
/// - Responsive navigation that adapts to screen size
///
/// Example:
/// ```dart
/// NavigationBar(
///   index: selectedIndex,
///   onSelected: (index) => setState(() => selectedIndex = index),
///   children: [
///     NavigationItem(
///       icon: Icon(Icons.home),
///       label: Text('Home'),
///       onPressed: () => _navigateToHome(),
///     ),
///     NavigationItem(
///       icon: Icon(Icons.search),
///       label: Text('Search'),
///       onPressed: () => _navigateToSearch(),
///     ),
///     NavigationDivider(),
///     NavigationItem(
///       icon: Icon(Icons.settings),
///       label: Text('Settings'),
///       onPressed: () => _navigateToSettings(),
///     ),
///   ],
/// );
/// ```
/// A flexible navigation container widget.
///
/// Provides a customizable navigation bar that can be configured for various
/// layouts including horizontal bars, vertical rails, and expandable sidebars.
/// Manages navigation item presentation and selection states.
///
/// Example:
/// ```dart
/// NavigationBar(
///   index: selectedIndex,
///   onSelected: (index) => setState(() => selectedIndex = index),
///   children: [
///     NavigationButton(child: Text('Home')),
///     NavigationButton(child: Text('Settings')),
///   ],
/// )
/// ```
class NavigationBar extends StatefulWidget {
  /// Background color of the navigation bar.
  final Color? backgroundColor;

  /// List of navigation items to display.
  final List<NavigationBarItem> children;

  /// Alignment of navigation items.
  final NavigationBarAlignment? alignment;

  /// Layout direction (horizontal or vertical).
  final Axis? direction;

  /// Spacing between navigation items.
  final double? spacing;

  /// Type of label display.
  final NavigationLabelType? labelType;

  /// Position of labels relative to icons.
  final NavigationLabelPosition? labelPosition;

  /// Size variant for labels.
  final NavigationLabelSize? labelSize;

  /// Internal padding of the navigation bar.
  final EdgeInsetsGeometry? padding;

  /// Whether the navigation bar expands to fill available space.
  final bool? expands;

  /// Currently selected item index.
  final int? index;

  /// Callback when an item is selected.
  final ValueChanged<int>? onSelected;

  /// Surface opacity for the navigation bar background.
  final double? surfaceOpacity;

  /// Surface blur amount for the navigation bar background.
  final double? surfaceBlur;

  /// Whether the navigation bar is in expanded state (for collapsible bars).
  final bool? expanded;

  /// Cross-axis size when the navigation bar is expanded.
  ///
  /// For horizontal bars, this sets the height. For vertical bars, this sets
  /// the width.
  final double? expandedSize;

  /// Cross-axis size when the navigation bar is collapsed.
  ///
  /// For horizontal bars, this sets the height. For vertical bars, this sets
  /// the width.
  final double? collapsedSize;

  /// Whether to keep cross-axis size when expanding/collapsing.
  final bool? keepCrossAxisSize;

  /// Whether to keep main-axis size when expanding/collapsing.
  final bool? keepMainAxisSize;

  /// Creates a [NavigationBar].
  const NavigationBar({
    super.key,
    this.backgroundColor,
    this.alignment,
    this.direction,
    this.spacing,
    this.labelType,
    this.labelPosition,
    this.labelSize,
    this.padding,
    this.expands,
    this.index,
    this.onSelected,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.expanded,
    this.expandedSize,
    this.collapsedSize,
    this.keepCrossAxisSize,
    this.keepMainAxisSize,
    required this.children,
  });

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar>
    with NavigationContainerMixin {
  void _onSelected(int index) {
    widget.onSelected?.call(index);
  }

  @override
  void didUpdateWidget(covariant NavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityGap = theme.density.baseGap * scaling;
    final densityContentPadding = theme.density.baseContentPadding * scaling;
    final compTheme = ComponentTheme.maybeOf<NavigationBarTheme>(context);
    final alignment = styleValue(
      widgetValue: widget.alignment,
      themeValue: compTheme?.alignment,
      defaultValue: NavigationBarAlignment.center,
    );
    final direction = styleValue(
      widgetValue: widget.direction,
      themeValue: compTheme?.direction,
      defaultValue: Axis.horizontal,
    );
    final spacing = styleValue<double>(
      widgetValue: widget.spacing,
      themeValue: compTheme?.spacing,
      defaultValue: densityGap,
    );
    final labelType = styleValue(
      widgetValue: widget.labelType,
      themeValue: compTheme?.labelType,
      defaultValue: NavigationLabelType.none,
    );
    final labelPosition = styleValue(
      widgetValue: widget.labelPosition,
      themeValue: compTheme?.labelPosition,
      defaultValue: NavigationLabelPosition.bottom,
    );
    final labelSize = styleValue(
      widgetValue: widget.labelSize,
      themeValue: compTheme?.labelSize,
      defaultValue: NavigationLabelSize.small,
    );
    final defaultPadding = EdgeInsets.symmetric(
      vertical: densityGap,
      horizontal: densityContentPadding * 0.75,
    );
    final parentPadding = styleValue(
      widgetValue: widget.padding,
      themeValue: compTheme?.padding,
      defaultValue: defaultPadding,
    );
    final backgroundColor = styleValue<Color?>(
      widgetValue: widget.backgroundColor,
      themeValue: compTheme?.backgroundColor,
      defaultValue: null,
    );
    final expands = widget.expands ?? true;
    final expanded = widget.expanded ?? true;
    var directionality = Directionality.of(context);
    var resolvedPadding = parentPadding.resolve(directionality);
    List<Widget> rawChildren = wrapChildren(context, widget.children);
    List<Widget> children = [];
    if (!expands) {
      children = List.of(rawChildren);
    } else {
      if (alignment == NavigationBarAlignment.spaceEvenly) {
        children.add(const Spacer());
        for (var i = 0; i < rawChildren.length; i++) {
          children.add(Expanded(child: rawChildren[i]));
        }
        children.add(const Spacer());
      } else if (alignment == NavigationBarAlignment.spaceAround) {
        children.add(const Spacer());
        for (var i = 0; i < rawChildren.length; i++) {
          children.add(Expanded(flex: 2, child: rawChildren[i]));
        }
        children.add(const Spacer());
      } else if (alignment == NavigationBarAlignment.spaceBetween) {
        for (var i = 0; i < rawChildren.length; i++) {
          if (i > 0) {
            children.add(const Spacer());
          }
          children.add(Expanded(flex: 2, child: rawChildren[i]));
        }
      } else {
        for (var i = 0; i < rawChildren.length; i++) {
          children.add(Expanded(child: rawChildren[i]));
        }
      }
    }
    Widget bar = AppBar(
      padding: EdgeInsets.zero,
      surfaceBlur: widget.surfaceBlur,
      surfaceOpacity: widget.surfaceOpacity,
      child: RepaintBoundary(
        child: Data.inherit(
          data: NavigationControlData(
            containerType: NavigationContainerType.bar,
            parentLabelType: labelType,
            parentLabelSize: labelSize,
            parentPadding: resolvedPadding,
            direction: direction,
            selectedIndex: widget.index,
            onSelected: _onSelected,
            parentLabelPosition: labelPosition,
            expanded: expanded,
            childCount: children.length,
            spacing: spacing,
            keepCrossAxisSize: widget.keepCrossAxisSize ?? false,
            keepMainAxisSize: widget.keepMainAxisSize ?? false,
          ),
          child: Container(
            color: backgroundColor,
            padding: resolvedPadding,
            // child: Flex(
            //   direction: direction,
            //   mainAxisAlignment: alignment.mainAxisAlignment,
            //   children: children,
            // ),
            child: _wrapIntrinsic(
              Flex(
                direction: direction,
                mainAxisAlignment: alignment.mainAxisAlignment,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
    if (widget.expandedSize != null || widget.collapsedSize != null) {
      final targetMinSize = expanded
          ? (widget.expandedSize ?? 0.0)
          : (widget.collapsedSize ?? 0.0);
      final maxSize = widget.expandedSize ?? double.infinity;
      bar = AnimatedValueBuilder<double>(
        value: targetMinSize,
        duration: kDefaultDuration,
        curve: Curves.easeInOut,
        builder: (context, animatedMinSize, child) {
          return ConstrainedBox(
            constraints: direction == Axis.vertical
                ? BoxConstraints(minWidth: animatedMinSize, maxWidth: maxSize)
                : BoxConstraints(
                    minHeight: animatedMinSize, maxHeight: maxSize),
            child: child,
          );
        },
        child: bar,
      );
    }
    return bar;
  }

  Widget _wrapIntrinsic(Widget child) {
    if (widget.direction == Axis.horizontal) {
      return IntrinsicHeight(child: child);
    }
    return IntrinsicWidth(child: child);
  }
}

double _startPadding(EdgeInsets padding, Axis direction) {
  if (direction == Axis.vertical) {
    return padding.top;
  }
  return padding.left;
}

double _endPadding(EdgeInsets padding, Axis direction) {
  if (direction == Axis.vertical) {
    return padding.bottom;
  }
  return padding.right;
}

/// A mixin for navigation containers that provides child wrapping functionality.
///
/// This mixin is used to enhance navigation containers with the ability to wrap
/// navigation items with necessary control data. It tracks item positions and
/// manages selectable state for proper navigation behavior.
mixin NavigationContainerMixin {
  /// Wraps navigation bar items with control data for selection tracking.
  ///
  /// Takes a list of [NavigationBarItem] children and wraps each with
  /// [NavigationChildControlData] that tracks the item's index and selection state.
  /// Only items with a selectable count of 1 receive a selection index, while
  /// non-selectable items have a null selection index.
  ///
  /// Parameters:
  /// - [context] (`BuildContext`, required): Build context for inherited data.
  /// - [children] (`List<NavigationBarItem>`, required): Navigation items to wrap.
  ///
  /// Returns: `List<Widget>` — wrapped navigation items with control data.
  ///
  /// Example:
  /// ```dart
  /// final wrappedItems = wrapChildren(
  ///   context,
  ///   [
  ///     NavigationItem(child: Icon(Icons.home)),
  ///     NavigationItem(child: Icon(Icons.settings)),
  ///   ],
  /// );
  /// ```
  List<Widget> wrapChildren(
    BuildContext context,
    List<NavigationBarItem> children, {
    int baseIndex = 0,
  }) {
    int index = baseIndex;
    List<Widget> newChildren = List.of(children);
    for (var i = 0; i < children.length; i++) {
      final child = children[i];
      final selectableCount = child.selectableCount;
      if (selectableCount > 1) {
        newChildren[i] = Data.inherit(
          data: NavigationChildControlData(index: null, actualIndex: i),
          child: Data.inherit(
            data: NavigationGroupControlData(
              baseIndex: index,
              selectableCount: selectableCount,
            ),
            child: child,
          ),
        );
        index += selectableCount;
        continue;
      }
      if (selectableCount == 1) {
        newChildren[i] = Data.inherit(
          data: NavigationChildControlData(index: index, actualIndex: i),
          child: child,
        );
        index++;
      } else {
        newChildren[i] = Data.inherit(
          data: NavigationChildControlData(index: null, actualIndex: i),
          child: child,
        );
      }
    }
    return newChildren;
  }
}

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

/// A full-width navigation sidebar component for comprehensive navigation.
///
/// Provides an expanded navigation interface designed for sidebar layouts
/// with full-width items and extensive labeling support. Unlike [NavigationRail],
/// the sidebar is optimized for detailed navigation with prominent labels,
/// descriptions, and expanded interactive areas.
///
/// The sidebar always displays labels and typically occupies a dedicated
/// sidebar area in layouts. Items are arranged vertically with generous
/// spacing and padding to create a comfortable navigation experience.
/// Supports badges, icons, and detailed labeling for complex navigation hierarchies.
///
/// Integrates with responsive layout systems and can be combined with
/// collapsible containers or drawer systems for adaptive navigation
/// experiences across different screen sizes and device types.
///
/// Example:
/// ```dart
/// NavigationSidebar(
///   backgroundColor: Colors.grey.shade50,
///   labelType: NavigationLabelType.all,
///   index: currentPageIndex,
///   onSelected: (index) => _navigateToPage(index),
///   children: [
///     NavigationBarItem(
///       icon: Icon(Icons.dashboard),
///       label: 'Dashboard',
///       badge: Badge(child: Text('New')),
///     ),
///     NavigationBarItem(
///       icon: Icon(Icons.analytics),
///       label: 'Analytics',
///     ),
///     NavigationBarItem(
///       icon: Icon(Icons.settings),
///       label: 'Settings',
///     ),
///   ],
/// )
/// ```
class NavigationSidebar extends StatefulWidget {
  /// Background color for the navigation sidebar surface.
  ///
  /// Sets the sidebar's background color to provide visual separation
  /// from content areas. When null, uses the theme's default surface color.
  final Color? backgroundColor;

  /// List of navigation items to display in the sidebar.
  ///
  /// Each item should be a [NavigationBarItem] that defines the navigation
  /// destination with icon, label, and optional badge. Items are arranged
  /// vertically with full-width presentation.
  final List<NavigationBarItem> children;

  /// Optional fixed header items displayed before the scrollable content.
  final List<NavigationBarItem>? header;

  /// Optional fixed footer items displayed after the scrollable content.
  final List<NavigationBarItem>? footer;

  /// Spacing between navigation items.
  ///
  /// Controls the vertical gap between adjacent navigation items.
  /// Larger values create more breathing room in the navigation list.
  final double? spacing;

  /// Label display behavior for navigation items.
  ///
  /// Determines how labels are presented in the sidebar. Sidebars typically
  /// use expanded label types to show comprehensive navigation information.
  final NavigationLabelType labelType;

  /// Position of labels relative to icons within items.
  ///
  /// Controls label placement within each navigation item. Sidebars
  /// commonly position labels to the end (right in LTR layouts) of icons.
  final NavigationLabelPosition labelPosition;

  /// Size variant for label text and item dimensions.
  ///
  /// Affects text size and overall item scale. Larger sizes improve
  /// accessibility and visual prominence in sidebar contexts.
  final NavigationLabelSize labelSize;

  /// Internal padding applied within the navigation sidebar.
  ///
  /// Provides space around navigation items, preventing them from
  /// touching the sidebar's edges and creating visual comfort.
  final EdgeInsetsGeometry? padding;

  /// Size constraints for the navigation sidebar container.
  ///
  /// Defines width and height bounds for the sidebar. Useful for
  /// responsive layouts and consistent sidebar sizing.
  final BoxConstraints? constraints;

  /// Index of the currently selected navigation item.
  ///
  /// Highlights the corresponding item with selected styling.
  /// When null, no item appears selected.
  final int? index;

  /// Callback invoked when a navigation item is selected.
  ///
  /// Called with the index of the selected item. Use this to update
  /// the selection state and handle navigation actions.
  final ValueChanged<int>? onSelected;

  /// Opacity level for surface background effects.
  ///
  /// Controls transparency of background overlays and blur effects.
  /// Values range from 0.0 (transparent) to 1.0 (opaque).
  final double? surfaceOpacity;

  /// Blur intensity for surface background effects.
  ///
  /// Controls backdrop blur effects behind the sidebar surface.
  /// Higher values create more pronounced blur effects.
  final double? surfaceBlur;

  /// Whether the sidebar should expand to fill available width.
  ///
  /// When true, the sidebar uses all available horizontal space.
  /// When false, the sidebar sizes itself to its content width.
  final bool expanded;

  /// Whether to maintain intrinsic size along the cross axis.
  ///
  /// Controls width sizing behavior when the sidebar's width
  /// constraints are unconstrained.
  final bool keepCrossAxisSize;

  /// Whether to maintain intrinsic size along the main axis.
  ///
  /// Controls height sizing behavior when the sidebar's height
  /// constraints are unconstrained.
  final bool keepMainAxisSize;

  /// Creates a [NavigationSidebar] with the specified configuration and items.
  ///
  /// The [children] parameter is required and should contain [NavigationBarItem]
  /// widgets that define the navigation destinations. Default values are
  /// optimized for sidebar presentation with expanded labels and large sizing.
  ///
  /// The sidebar defaults to expanded label presentation with large sizing
  /// and end-positioned labels, creating a comprehensive navigation experience
  /// suitable for desktop and tablet interfaces.
  ///
  /// Parameters:
  /// - [children] (`List<NavigationBarItem>`, required): Navigation destinations
  /// - [labelType] (NavigationLabelType, default: expanded): Label display behavior
  /// - [labelPosition] (NavigationLabelPosition, default: end): Label positioning
  /// - [labelSize] (NavigationLabelSize, default: large): Size variant for items
  /// - [index] (int?, optional): Currently selected item index
  /// - [onSelected] (`ValueChanged<int>?`, optional): Selection change callback
  /// - [expanded] (bool, default: true): Whether to fill available width
  ///
  /// Example:
  /// ```dart
  /// NavigationSidebar(
  ///   backgroundColor: Theme.of(context).colorScheme.surface,
  ///   index: selectedIndex,
  ///   onSelected: (index) => _handleNavigation(index),
  ///   children: sidebarItems,
  /// )
  /// ```
  const NavigationSidebar({
    super.key,
    this.backgroundColor,
    this.spacing,
    this.labelType = NavigationLabelType.expanded,
    this.labelPosition = NavigationLabelPosition.end,
    this.labelSize = NavigationLabelSize.large,
    this.padding,
    this.constraints,
    this.index,
    this.onSelected,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.expanded = true,
    this.keepCrossAxisSize = false,
    this.keepMainAxisSize = false,
    this.header,
    this.footer,
    required this.children,
  });

  @override
  State<NavigationSidebar> createState() => _NavigationSidebarState();
}

class _NavigationSidebarState extends State<NavigationSidebar>
    with NavigationContainerMixin {
  BoxConstraints getDefaultConstraints(BuildContext context, ThemeData theme) {
    final scaling = theme.scaling;
    return BoxConstraints(minWidth: 200 * scaling, maxWidth: 200 * scaling);
  }

  EdgeInsets _childPadding(EdgeInsets padding, Axis direction) {
    if (direction == Axis.vertical) {
      return EdgeInsets.only(left: padding.left, right: padding.right);
    }
    return EdgeInsets.only(top: padding.top, bottom: padding.bottom);
  }

  void _onSelected(int index) {
    widget.onSelected?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityGap = theme.density.baseGap * scaling;
    final densityContentPadding = theme.density.baseContentPadding * scaling;
    final headerItems = widget.header ?? const <NavigationBarItem>[];
    final footerItems = widget.footer ?? const <NavigationBarItem>[];
    int headerSelectable = 0;
    for (final item in headerItems) {
      headerSelectable += item.selectableCount;
    }
    int bodySelectable = 0;
    for (final item in widget.children) {
      bodySelectable += item.selectableCount;
    }
    final headerChildren = wrapChildren(context, headerItems, baseIndex: 0);
    final bodyChildren =
        wrapChildren(context, widget.children, baseIndex: headerSelectable);
    final footerChildren = wrapChildren(
      context,
      footerItems,
      baseIndex: headerSelectable + bodySelectable,
    );
    var parentPadding = widget.padding ??
        EdgeInsets.symmetric(
          vertical: densityGap,
          horizontal: densityContentPadding * 0.75,
        );
    var directionality = Directionality.of(context);
    var resolvedPadding = parentPadding.resolve(directionality);
    const direction = Axis.vertical;
    return Data.inherit(
      data: NavigationControlData(
        containerType: NavigationContainerType.sidebar,
        parentLabelType: widget.labelType,
        parentLabelPosition: widget.labelPosition,
        parentLabelSize: widget.labelSize,
        parentPadding: resolvedPadding,
        direction: direction,
        onSelected: _onSelected,
        selectedIndex: widget.index,
        expanded: widget.expanded,
        childCount: widget.children.length,
        spacing: widget.spacing ?? 0,
        keepCrossAxisSize: widget.keepCrossAxisSize,
        keepMainAxisSize: widget.keepMainAxisSize,
      ),
      child: ConstrainedBox(
        constraints:
            widget.constraints ?? getDefaultConstraints(context, theme),
        child: SurfaceBlur(
          surfaceBlur: widget.surfaceBlur,
          child: Container(
            color: widget.backgroundColor,
            child: ClipRect(
              child: RepaintBoundary(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (headerChildren.isNotEmpty)
                      _buildFixedSection(
                        context,
                        headerChildren,
                        EdgeInsets.zero,
                      ),
                    Expanded(
                      child: CustomScrollView(
                        clipBehavior: Clip.none,
                        shrinkWrap: true,
                        scrollDirection: direction,
                        slivers: [
                          SliverGap(_startPadding(resolvedPadding, direction)),
                          ...bodyChildren.map((e) {
                            return SliverPadding(
                              padding: _childPadding(
                                resolvedPadding,
                                direction,
                              ),
                              sliver: e,
                            ) as Widget;
                          }).joinSeparator(SliverGap(widget.spacing ?? 0)),
                          SliverGap(_endPadding(resolvedPadding, direction)),
                        ],
                      ),
                    ),
                    if (footerChildren.isNotEmpty)
                      _buildFixedSection(
                        context,
                        footerChildren,
                        EdgeInsets.zero,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFixedSection(
    BuildContext context,
    List<Widget> items,
    EdgeInsets resolvedPadding,
  ) {
    return Data.inherit(
      data: NavigationControlData(
        containerType: NavigationContainerType.sidebar,
        parentLabelType: widget.labelType,
        parentLabelPosition: widget.labelPosition,
        parentLabelSize: widget.labelSize,
        parentPadding: resolvedPadding,
        direction: Axis.vertical,
        onSelected: _onSelected,
        selectedIndex: widget.index,
        expanded: widget.expanded,
        childCount: items.length,
        spacing: widget.spacing ?? 0,
        keepCrossAxisSize: widget.keepCrossAxisSize,
        keepMainAxisSize: widget.keepMainAxisSize,
      ),
      child: CustomScrollView(
        clipBehavior: Clip.none,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        slivers: [
          SliverGap(_startPadding(resolvedPadding, Axis.vertical)),
          ...items.map((e) {
            return SliverPadding(
              padding: _childPadding(resolvedPadding, Axis.vertical),
              sliver: e,
            ) as Widget;
          }).joinSeparator(SliverGap(widget.spacing ?? 0)),
          SliverGap(_endPadding(resolvedPadding, Axis.vertical)),
        ],
      ),
    );
  }
}

/// Determines when labels are shown in navigation items.
enum NavigationLabelType {
  /// No labels displayed.
  none,

  /// Labels shown only for selected items.
  selected,

  /// Labels always shown for all items.
  all,

  /// Labels shown as tooltips on hover.
  tooltip,

  /// Labels shown when navigation is expanded.
  expanded,
}

/// Position of navigation item labels relative to icons.
enum NavigationLabelPosition {
  /// Label before icon (left in LTR, right in RTL)
  start,

  /// Label after icon (right in LTR, left in RTL)
  end,

  /// Label above icon
  top,

  /// Label below icon
  bottom,
}

/// Size variant for navigation item labels.
enum NavigationLabelSize {
  /// Compact label text
  small,

  /// Larger label text
  large,
}

/// Data class tracking navigation child position and selection state.
///
/// Associates a navigation item with its logical index (for selection)
/// and actual index (for layout position).
class NavigationChildControlData {
  /// Logical index for selection (null if not selectable).
  final int? index;

  /// Actual position index in the navigation layout.
  final int actualIndex;

  /// Creates navigation child control data.
  ///
  /// Parameters:
  /// - [index] (int?): Logical selection index
  /// - [actualIndex] (int, required): Layout position index
  NavigationChildControlData({this.index, required this.actualIndex});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NavigationChildControlData &&
        other.index == index &&
        other.actualIndex == actualIndex;
  }

  @override
  int get hashCode {
    return Object.hash(index, actualIndex);
  }
}

/// Data class containing navigation control configuration and state.
///
/// Manages layout, styling, and interaction settings for navigation
/// containers and their children. Used internally to coordinate
/// behavior across navigation items.
class NavigationControlData {
  /// Type of navigation container (bar, rail, etc.).
  final NavigationContainerType containerType;

  /// Label display type from parent container.
  final NavigationLabelType parentLabelType;

  /// Label position relative to icon from parent.
  final NavigationLabelPosition parentLabelPosition;

  /// Label size variant from parent.
  final NavigationLabelSize parentLabelSize;

  /// Padding applied by parent container.
  final EdgeInsets parentPadding;

  /// Layout direction (horizontal or vertical).
  final Axis direction;

  /// Currently selected item index (null if none selected).
  final int? selectedIndex;

  /// Total number of child items.
  final int childCount;

  /// Callback when an item is selected.
  final ValueChanged<int>? onSelected;

  /// Whether the navigation is expanded to fill available space.
  final bool expanded;

  /// Spacing between navigation items.
  final double spacing;

  /// Whether to maintain cross-axis size constraints.
  final bool keepCrossAxisSize;

  /// Whether to maintain main-axis size constraints.
  final bool keepMainAxisSize;

  /// Computed label direction based on parent label position.
  ///
  /// Returns horizontal for start/end positions, vertical for top/bottom.
  Axis get labelDirection {
    return parentLabelPosition == NavigationLabelPosition.start ||
            parentLabelPosition == NavigationLabelPosition.end
        ? Axis.horizontal
        : Axis.vertical;
  }

  /// Creates navigation control data.
  ///
  /// Parameters:
  /// - [containerType] (NavigationContainerType, required): Container type
  /// - [parentLabelType] (NavigationLabelType, required): Label display type
  /// - [parentLabelPosition] (NavigationLabelPosition, required): Label position
  /// - [parentLabelSize] (NavigationLabelSize, required): Label size variant
  /// - [parentPadding] (EdgeInsets, required): Container padding
  /// - [direction] (Axis, required): Layout direction
  /// - [selectedIndex] (int?): Selected item index
  /// - [onSelected] (`ValueChanged<int>`, required): Selection callback
  /// - [expanded] (bool, required): Whether expanded
  /// - [childCount] (int, required): Number of children
  /// - [spacing] (double, required): Item spacing
  /// - [keepCrossAxisSize] (bool, required): Maintain cross-axis size
  /// - [keepMainAxisSize] (bool, required): Maintain main-axis size
  NavigationControlData({
    required this.containerType,
    required this.parentLabelType,
    required this.parentLabelPosition,
    required this.parentLabelSize,
    required this.parentPadding,
    required this.direction,
    this.selectedIndex,
    this.onSelected,
    required this.expanded,
    required this.childCount,
    required this.spacing,
    required this.keepCrossAxisSize,
    required this.keepMainAxisSize,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NavigationControlData &&
        other.containerType == containerType &&
        other.parentLabelType == parentLabelType &&
        other.parentPadding == parentPadding &&
        other.direction == direction &&
        other.selectedIndex == selectedIndex &&
        other.onSelected == onSelected &&
        other.parentLabelPosition == parentLabelPosition &&
        other.parentLabelSize == parentLabelSize &&
        other.expanded == expanded &&
        other.childCount == childCount &&
        other.spacing == spacing &&
        other.keepCrossAxisSize == keepCrossAxisSize &&
        other.keepMainAxisSize == keepMainAxisSize;
  }

  @override
  int get hashCode {
    return Object.hash(
      containerType,
      parentLabelType,
      parentPadding,
      direction,
      selectedIndex,
      onSelected,
      parentLabelPosition,
      parentLabelSize,
      expanded,
      childCount,
      spacing,
      keepCrossAxisSize,
      keepMainAxisSize,
    );
  }
}

/// Control data for navigation groups with nested items.
///
/// Provides the base selection index for nested items and the total count
/// of selectable children within a group.
class NavigationGroupControlData {
  /// Base selection index for the group's first selectable child.
  final int baseIndex;

  /// Total number of selectable items within the group.
  final int selectableCount;

  /// Creates group control data.
  const NavigationGroupControlData({
    required this.baseIndex,
    required this.selectableCount,
  });
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

/// Selectable navigation item with selection state management.
///
/// Represents a clickable navigation item that can be selected. Supports
/// custom styling for selected/unselected states, labels, and icons.
///
/// Example:
/// ```dart
/// NavigationItem(
///   index: 0,
///   label: Text('Home'),
///   child: Icon(Icons.home),
///   selected: selectedIndex == 0,
///   onChanged: (selected) => setState(() => selectedIndex = 0),
/// )
/// ```
class NavigationItem extends AbstractNavigationButton {
  /// Custom style when item is selected.
  final AbstractButtonStyle? selectedStyle;

  /// Whether this item is currently selected.
  final bool? selected;

  /// Callback when selection state changes.
  final ValueChanged<bool>? onChanged;

  /// Optional index for selection management.
  final int? index;

  /// Creates a navigation item.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Icon or content widget
  /// - [selectedStyle] (AbstractButtonStyle?): Style when selected
  /// - [selected] (bool?): Current selection state
  /// - [onChanged] (`ValueChanged<bool>?`): Selection change callback
  /// - [index] (int?): Item index for selection
  /// - [label] (Widget?): Optional label text
  /// - [spacing] (double?): Space between icon and label
  /// - [style] (AbstractButtonStyle?): Default style
  /// - [alignment] (AlignmentGeometry?): Content alignment
  /// - [enabled] (bool?): Whether enabled for interaction
  /// - [overflow] (TextOverflow?): Label overflow behavior
  /// - [marginAlignment] (AlignmentGeometry?): Margin alignment
  const NavigationItem({
    super.key,
    this.selectedStyle,
    this.selected,
    this.onChanged,
    super.label,
    super.spacing,
    super.style,
    super.alignment,
    this.index,
    super.enabled,
    super.overflow,
    super.marginAlignment,
    required super.child,
  });

  @override
  int get selectableCount {
    // if index is not null, then the child itself handles the selection
    // if index is null, then the parent handles the selection
    return index == null ? 1 : 0;
  }

  @override
  State<AbstractNavigationButton> createState() => _NavigationItemState();
}

class _NavigationItemState
    extends _AbstractNavigationButtonState<NavigationItem> {
  @override
  Widget buildBox(
    BuildContext context,
    NavigationControlData? data,
    NavigationChildControlData? childData,
  ) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityGap = theme.density.baseGap * scaling;
    final labelType = data?.parentLabelType ?? NavigationLabelType.none;
    final direction = data?.direction ?? Axis.vertical;
    var index = childData?.index ?? widget.index;
    var isSelected = widget.selected ?? index == data?.selectedIndex;
    var parentIndex = childData?.index;
    bool showLabel = labelType == NavigationLabelType.all ||
        (labelType == NavigationLabelType.selected && isSelected) ||
        (labelType == NavigationLabelType.expanded && data?.expanded == true);
    AbstractButtonStyle style = widget.style ??
        (data?.containerType != NavigationContainerType.sidebar
            ? const ButtonStyle.ghost(density: ButtonDensity.icon)
            : const ButtonStyle.ghost());
    AbstractButtonStyle selectedStyle = widget.selectedStyle ??
        (data?.containerType != NavigationContainerType.sidebar
            ? const ButtonStyle.secondary(density: ButtonDensity.icon)
            : const ButtonStyle.secondary());

    Widget? label = widget.label == null
        ? const SizedBox()
        : DefaultTextStyle.merge(
            textAlign: TextAlign.center,
            child: _NavigationChildOverflowHandle(
              overflow: widget.overflow,
              child: data?.parentLabelSize == NavigationLabelSize.small
                  ? widget.label!.xSmall()
                  : widget.label!,
            ),
          );
    var canShowLabel = (labelType == NavigationLabelType.expanded ||
        labelType == NavigationLabelType.all ||
        labelType == NavigationLabelType.selected);
    return NavigationPadding(
      child: SelectedButton(
        value: isSelected,
        enabled: widget.enabled,
        onChanged: parentIndex != null || widget.index != null
            ? (value) {
                widget.onChanged?.call(value);
                data?.onSelected?.call(parentIndex ?? widget.index!);
              }
            : widget.onChanged,
        marginAlignment: widget.marginAlignment,
        style: style,
        selectedStyle: selectedStyle,
        alignment: widget.alignment ??
            () {
              if (data?.expanded == true) {
                return Alignment.center;
              }
              if (data?.containerType == NavigationContainerType.sidebar &&
                  data?.labelDirection == Axis.horizontal) {
                if (data?.parentLabelPosition ==
                    NavigationLabelPosition.start) {
                  return AlignmentDirectional.centerEnd;
                } else if (data?.parentLabelPosition ==
                    NavigationLabelPosition.end) {
                  return AlignmentDirectional.centerStart;
                } else {
                  return Alignment.center;
                }
              }
              return null;
            }(),
        child: _NavigationLabeled(
          label: label,
          showLabel: showLabel,
          labelType: labelType,
          direction: direction,
          keepMainAxisSize: (data?.keepMainAxisSize ?? false) && canShowLabel,
          keepCrossAxisSize: (data?.keepCrossAxisSize ?? false) && canShowLabel,
          position: data?.parentLabelPosition ?? NavigationLabelPosition.bottom,
          spacing: widget.spacing ?? densityGap,
          child: widget.child,
        ),
      ),
    );
  }
}

/// Non-selectable navigation button for actions.
///
/// Similar to [NavigationItem] but without selection state. Used for
/// action buttons in navigation (e.g., settings, logout) that trigger
/// callbacks rather than changing navigation state.
///
/// Example:
/// ```dart
/// NavigationButton(
///   label: Text('Settings'),
///   child: Icon(Icons.settings),
///   onPressed: () => _openSettings(),
/// )
/// ```
class NavigationButton extends AbstractNavigationButton {
  /// Callback when button is pressed.
  final VoidCallback? onPressed;
  final bool? enableFeedback;

  /// Creates a navigation button.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Icon or content widget
  /// - [enableFeedback] (bool?) : Whether to enable haptic feedback
  /// - [onPressed] (VoidCallback?): Press callback
  /// - [label] (Widget?): Optional label text
  /// - [spacing] (double?): Space between icon and label
  /// - [style] (AbstractButtonStyle?): Button style
  /// - [alignment] (AlignmentGeometry?): Content alignment
  /// - [enabled] (bool?): Whether enabled for interaction
  /// - [overflow] (TextOverflow?): Label overflow behavior
  /// - [marginAlignment] (AlignmentGeometry?): Margin alignment
  const NavigationButton({
    super.key,
    this.onPressed,
    this.enableFeedback = true,
    super.label,
    super.spacing,
    super.style,
    super.alignment,
    super.enabled,
    super.overflow,
    super.marginAlignment,
    required super.child,
  });

  @override
  int get selectableCount => 0;

  @override
  State<AbstractNavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState
    extends _AbstractNavigationButtonState<NavigationButton> {
  @override
  Widget buildBox(
    BuildContext context,
    NavigationControlData? data,
    NavigationChildControlData? childData,
  ) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityGap = theme.density.baseGap * scaling;
    final labelType = data?.parentLabelType ?? NavigationLabelType.none;
    final direction = data?.direction ?? Axis.vertical;
    bool showLabel = labelType == NavigationLabelType.all ||
        (labelType == NavigationLabelType.expanded && data?.expanded == true);
    AbstractButtonStyle style = widget.style ??
        (data?.containerType != NavigationContainerType.sidebar
            ? const ButtonStyle.ghost(density: ButtonDensity.icon)
            : const ButtonStyle.ghost());

    Widget? label = widget.label == null
        ? const SizedBox()
        : DefaultTextStyle.merge(
            textAlign: TextAlign.center,
            child: _NavigationChildOverflowHandle(
              overflow: widget.overflow,
              child: data?.parentLabelSize == NavigationLabelSize.small
                  ? widget.label!.xSmall()
                  : widget.label!,
            ),
          );
    var canShowLabel = (labelType == NavigationLabelType.expanded ||
        labelType == NavigationLabelType.all ||
        labelType == NavigationLabelType.selected);
    return NavigationPadding(
      child: Button(
        enabled: widget.enabled,
        onPressed: widget.onPressed,
        marginAlignment: widget.marginAlignment,
        style: style,
        enableFeedback: widget.enableFeedback,
        alignment: widget.alignment ??
            (data?.containerType == NavigationContainerType.sidebar &&
                    data?.labelDirection == Axis.horizontal
                ? (data?.parentLabelPosition == NavigationLabelPosition.start
                    ? AlignmentDirectional.centerEnd
                    : AlignmentDirectional.centerStart)
                : null),
        child: _NavigationLabeled(
          label: label,
          showLabel: showLabel,
          labelType: labelType,
          direction: direction,
          keepMainAxisSize: (data?.keepMainAxisSize ?? false) && canShowLabel,
          keepCrossAxisSize: (data?.keepCrossAxisSize ?? false) && canShowLabel,
          position: data?.parentLabelPosition ?? NavigationLabelPosition.bottom,
          spacing: widget.spacing ?? densityGap,
          child: widget.child,
        ),
      ),
    );
  }
}

/// A navigation item that can expand to reveal nested navigation items.
///
/// Provides a labeled header row that toggles visibility of sub-items. Intended
/// for hierarchical navigation structures, especially in vertical sidebars or
/// rails.
class NavigationGroup extends StatefulWidget implements NavigationBarItem {
  /// Optional leading widget for the group header.
  final Widget? leading;

  /// Label widget for the group header.
  final Widget label;

  /// The nested navigation items for this group.
  final List<NavigationBarItem> children;

  /// Whether the group is expanded (controlled mode).
  final bool? expanded;

  /// Initial expanded state when uncontrolled.
  final bool initialExpanded;

  /// Callback when expansion state changes.
  final ValueChanged<bool>? onExpandedChanged;

  /// Custom style when the group header is selected.
  final AbstractButtonStyle? selectedStyle;

  /// Whether the group header is currently selected.
  final bool? selected;

  /// Callback when header selection changes.
  final ValueChanged<bool>? onChanged;

  /// Optional index for selection management.
  final int? index;

  /// Whether the group header is selectable.
  final bool selectable;

  /// Optional button style for the header.
  final AbstractButtonStyle? style;

  /// Optional custom trailing widget for the expand indicator.
  final Widget? trailing;

  /// Indentation applied to nested items.
  final double? childIndent;

  /// Branch line style for connecting group items.
  final BranchLine? branchLine;

  /// Spacing between leading widget and label.
  final double? spacing;

  /// Content alignment within the header button.
  final AlignmentGeometry? alignment;

  /// Whether the header is enabled for interaction.
  final bool? enabled;

  /// How to handle label overflow.
  final NavigationOverflow overflow;

  /// Creates a [NavigationGroup].
  const NavigationGroup({
    super.key,
    this.leading,
    required this.label,
    required this.children,
    this.expanded,
    this.initialExpanded = false,
    this.onExpandedChanged,
    this.selectedStyle,
    this.selected,
    this.onChanged,
    this.index,
    this.selectable = false,
    this.style,
    this.trailing,
    this.childIndent,
    this.branchLine,
    this.spacing,
    this.alignment,
    this.enabled,
    this.overflow = NavigationOverflow.marquee,
  });

  @override

  /// Total number of selectable children, including nested groups.
  int get selectableCount {
    int count = (selectable && index == null) ? 1 : 0;
    for (final child in children) {
      count += child.selectableCount;
    }
    return count;
  }

  @override
  State<NavigationGroup> createState() => _NavigationGroupState();
}

class _NavigationGroupState extends State<NavigationGroup>
    with NavigationContainerMixin {
  late bool _expanded;

  bool get _isExpanded => widget.expanded ?? _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.expanded ?? widget.initialExpanded;
  }

  @override
  void didUpdateWidget(covariant NavigationGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expanded != null && widget.expanded != oldWidget.expanded) {
      _expanded = widget.expanded ?? _expanded;
    }
  }

  void _toggleExpanded() {
    if (widget.enabled == false || widget.children.isEmpty) {
      return;
    }
    final next = !_isExpanded;
    if (widget.expanded == null) {
      setState(() {
        _expanded = next;
      });
    }
    widget.onExpandedChanged?.call(next);
  }

  EdgeInsetsGeometry _indentForDirection(double indent, Axis direction) {
    if (direction == Axis.vertical) {
      return EdgeInsetsDirectional.only(start: indent);
    }
    return EdgeInsetsDirectional.only(top: indent);
  }

  Widget _buildGroupGuide(
    BuildContext context,
    int childIndex,
    int childCount,
    Axis direction,
  ) {
    if (direction != Axis.vertical) {
      return const SizedBox.shrink();
    }
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityGap = theme.density.baseGap * scaling;
    final depth = [TreeNodeDepth(childIndex, childCount)];
    final compTheme = ComponentTheme.maybeOf<TreeTheme>(context);
    final branchLine =
        widget.branchLine ?? compTheme?.branchLine ?? BranchLine.line;
    final guideIndex = branchLine is IndentGuideLine ? 1 : 0;
    final guide = branchLine.build(context, depth, guideIndex);
    return SizedBox(width: densityGap * 2, child: guide);
  }

  Widget _wrapGroupChild(
    BuildContext context,
    Widget child,
    int childIndex,
    int childCount,
    Axis direction,
  ) {
    final guide = _buildGroupGuide(context, childIndex, childCount, direction);
    if (direction != Axis.vertical) {
      return child;
    }
    if (child is SliverToBoxAdapter) {
      return SliverToBoxAdapter(
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              guide,
              Expanded(child: child.child ?? const SizedBox.shrink()),
            ],
          ),
        ),
      );
    }
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          guide,
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, NavigationControlData? data) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityGap = theme.density.baseGap * scaling;
    final labelType = data?.parentLabelType ?? NavigationLabelType.none;
    final direction = data?.direction ?? Axis.vertical;
    final showLabel = labelType == NavigationLabelType.all ||
        (labelType == NavigationLabelType.expanded && data?.expanded == true);
    final canShowLabel = labelType == NavigationLabelType.expanded ||
        labelType == NavigationLabelType.all ||
        labelType == NavigationLabelType.selected;
    final label = DefaultTextStyle.merge(
      textAlign: TextAlign.center,
      child: _NavigationChildOverflowHandle(
        overflow: widget.overflow,
        child: data?.parentLabelSize == NavigationLabelSize.small
            ? widget.label.xSmall()
            : widget.label,
      ),
    );
    final content = _NavigationLabeled(
      label: label,
      showLabel: showLabel,
      labelType: labelType,
      direction: direction,
      keepMainAxisSize: (data?.keepMainAxisSize ?? false) && canShowLabel,
      keepCrossAxisSize: (data?.keepCrossAxisSize ?? false) && canShowLabel,
      position: data?.parentLabelPosition ?? NavigationLabelPosition.bottom,
      spacing: widget.spacing ?? densityGap,
      child: widget.leading ?? const SizedBox.shrink(),
    );

    AbstractButtonStyle style = widget.style ??
        (data?.containerType != NavigationContainerType.sidebar
            ? const ButtonStyle.ghost(density: ButtonDensity.icon)
            : const ButtonStyle.ghost());
    AbstractButtonStyle selectedStyle = widget.selectedStyle ??
        (data?.containerType != NavigationContainerType.sidebar
            ? const ButtonStyle.secondary(density: ButtonDensity.icon)
            : const ButtonStyle.secondary());

    final hasChildren = widget.children.isNotEmpty;
    final trailing = hasChildren
        ? Hidden(
            hidden: !(data?.expanded ?? true),
            direction: Axis.horizontal,
            curve: Curves.easeInOut,
            duration: kDefaultDuration,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap(densityGap),
                AnimatedRotation(
                  turns: _isExpanded ? 0.5 : 0.0,
                  duration: kDefaultDuration,
                  curve: Curves.easeInOut,
                  child: IconTheme.merge(
                    data: IconThemeData(size: 16 * scaling),
                    child: widget.trailing ?? const Icon(Icons.expand_more),
                  ),
                ),
              ],
            ),
          )
        : null;

    final parentExpanded = data?.expanded ?? true;
    final groupData = Data.maybeOf<NavigationGroupControlData>(context);
    final canSelectHeader = widget.selectable;
    final headerIndex = canSelectHeader
        ? (widget.index ??
            ((widget.index == null && groupData != null)
                ? groupData.baseIndex
                : null))
        : null;
    final isSelected = canSelectHeader
        ? (widget.selected ?? headerIndex == data?.selectedIndex)
        : false;

    Widget header = SelectedButton(
      value: isSelected,
      enabled: widget.enabled,
      onChanged: (value) {
        widget.onChanged?.call(value);
        if (headerIndex != null) {
          data?.onSelected?.call(headerIndex);
        }
        if (hasChildren && parentExpanded) {
          _toggleExpanded();
        }
      },
      style: style,
      selectedStyle: selectedStyle,
      alignment: widget.alignment ??
          (data?.containerType == NavigationContainerType.sidebar &&
                  data?.labelDirection == Axis.horizontal
              ? (data?.parentLabelPosition == NavigationLabelPosition.start
                  ? AlignmentDirectional.centerEnd
                  : AlignmentDirectional.centerStart)
              : null),
      child: Row(
        children: [
          Expanded(child: content),
          if (trailing != null) trailing,
        ],
      ),
    );

    if (labelType == NavigationLabelType.tooltip) {
      AlignmentGeometry alignment = Alignment.topCenter;
      AlignmentGeometry anchorAlignment = Alignment.bottomCenter;
      if (direction == Axis.vertical) {
        alignment = AlignmentDirectional.centerStart;
        anchorAlignment = AlignmentDirectional.centerEnd;
      }
      header = Tooltip(
        waitDuration: !isMobile(theme.platform)
            ? Duration.zero
            : const Duration(milliseconds: 500),
        alignment: alignment,
        anchorAlignment: anchorAlignment,
        tooltip: TooltipContainer(child: widget.label).call,
        child: header,
      );
    }

    return NavigationPadding(child: header);
  }

  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<NavigationControlData>(context);
    final groupData = Data.maybeOf<NavigationGroupControlData>(context);
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityGap = theme.density.baseGap * scaling;
    final direction = data?.direction ?? Axis.vertical;
    final baseIndex = groupData?.baseIndex ?? 0;
    final headerOffset = (widget.selectable && widget.index == null) ? 1 : 0;
    final wrappedChildren = wrapChildren(
      context,
      widget.children,
      baseIndex: baseIndex + headerOffset,
    );
    final childControlData = data == null
        ? null
        : NavigationControlData(
            containerType: data.containerType,
            parentLabelType: data.parentLabelType,
            parentLabelPosition: data.parentLabelPosition,
            parentLabelSize: data.parentLabelSize,
            parentPadding: data.parentPadding,
            direction: Axis.vertical,
            selectedIndex: data.selectedIndex,
            onSelected: data.onSelected,
            expanded: data.expanded,
            childCount: wrappedChildren.length,
            spacing: data.spacing,
            keepCrossAxisSize: data.keepCrossAxisSize,
            keepMainAxisSize: data.keepMainAxisSize,
          );

    final indent = widget.childIndent ?? densityGap;
    final indentPadding = _indentForDirection(indent, direction);

    final parentExpanded = data?.expanded ?? true;
    if (data?.containerType == NavigationContainerType.sidebar) {
      final decoratedChildren = <Widget>[];
      for (var i = 0; i < wrappedChildren.length; i++) {
        decoratedChildren.add(
          _wrapGroupChild(
            context,
            wrappedChildren[i],
            i,
            wrappedChildren.length,
            direction,
          ),
        );
      }
      final slivers = <Widget>[
        SliverToBoxAdapter(child: _buildHeader(context, data)),
        if (parentExpanded && _isExpanded && decoratedChildren.isNotEmpty)
          ...decoratedChildren.map(
            (child) => SliverPadding(
              padding: indentPadding,
              sliver: Data.inherit(
                data: childControlData,
                child: child,
              ),
            ),
          ),
      ];
      return SliverMainAxisGroup(slivers: slivers);
    }

    final decoratedChildren = <Widget>[];
    for (var i = 0; i < wrappedChildren.length; i++) {
      decoratedChildren.add(
        _wrapGroupChild(
          context,
          wrappedChildren[i],
          i,
          wrappedChildren.length,
          direction,
        ),
      );
    }
    final childList = Data.inherit(
      data: childControlData,
      child: Padding(
        padding: indentPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: decoratedChildren,
        ),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader(context, data),
        ClipRect(
          child: Hidden(
            hidden: !_isExpanded || !parentExpanded,
            direction: Axis.vertical,
            curve: Curves.easeInOut,
            duration: kDefaultDuration,
            child: childList,
          ),
        ),
      ],
    );
  }
}

/// Abstract base class for navigation button widgets.
///
/// Provides common properties and behavior for navigation items and buttons.
/// Subclasses include [NavigationItem] and [NavigationButton].
///
/// Handles layout, labels, styling, and integration with navigation containers.
abstract class AbstractNavigationButton extends StatefulWidget
    implements NavigationBarItem {
  /// Main content widget (typically an icon).
  final Widget child;

  /// Optional label text widget.
  final Widget? label;

  /// Spacing between icon and label.
  final double? spacing;

  /// Custom button style.
  final AbstractButtonStyle? style;

  /// Content alignment within the button.
  final AlignmentGeometry? alignment;

  /// Whether the button is enabled for interaction.
  final bool? enabled;

  /// How to handle label overflow.
  final NavigationOverflow overflow;

  /// Alignment for margins.
  final AlignmentGeometry? marginAlignment;

  /// Creates an abstract navigation button.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Main content (icon)
  /// - [spacing] (double?): Icon-label spacing
  /// - [label] (Widget?): Label widget
  /// - [style] (AbstractButtonStyle?): Button style
  /// - [alignment] (AlignmentGeometry?): Content alignment
  /// - [enabled] (bool?): Enabled state
  /// - [overflow] (NavigationOverflow): Overflow behavior, defaults to marquee
  /// - [marginAlignment] (AlignmentGeometry?): Margin alignment
  const AbstractNavigationButton({
    super.key,
    this.spacing,
    this.label,
    this.style,
    this.alignment,
    this.enabled,
    this.overflow = NavigationOverflow.marquee,
    this.marginAlignment,
    required this.child,
  });

  @override
  State<AbstractNavigationButton> createState();
}

abstract class _AbstractNavigationButtonState<
    T extends AbstractNavigationButton> extends State<T> {
  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<NavigationControlData>(context);
    final childData = Data.maybeOf<NavigationChildControlData>(context);
    if (data?.containerType == NavigationContainerType.sidebar) {
      return buildSliver(context, data, childData);
    }
    final labelType = data?.parentLabelType ?? NavigationLabelType.none;
    if (labelType == NavigationLabelType.tooltip) {
      return buildTooltip(context, data, childData);
    }
    return _buildBox(context, data, childData);
  }

  Widget buildTooltip(
    BuildContext context,
    NavigationControlData? data,
    NavigationChildControlData? childData,
  ) {
    if (widget.label == null) {
      return buildBox(context, data, childData);
    }
    AlignmentGeometry alignment = Alignment.topCenter;
    AlignmentGeometry anchorAlignment = Alignment.bottomCenter;
    if (data?.direction == Axis.vertical) {
      alignment = AlignmentDirectional.centerStart;
      anchorAlignment = AlignmentDirectional.centerEnd;
    }
    return Tooltip(
      waitDuration: !isMobile(Theme.of(context).platform)
          ? Duration.zero
          : const Duration(milliseconds: 500),
      alignment: alignment,
      anchorAlignment: anchorAlignment,
      tooltip: TooltipContainer(child: widget.label!).call,
      child: buildBox(context, data, childData),
    );
  }

  Widget buildSliver(
    BuildContext context,
    NavigationControlData? data,
    NavigationChildControlData? childData,
  ) {
    final labelType = data?.parentLabelType ?? NavigationLabelType.none;
    if (labelType == NavigationLabelType.tooltip) {
      return SliverToBoxAdapter(child: buildTooltip(context, data, childData));
    }
    return SliverToBoxAdapter(child: _buildBox(context, data, childData));
  }

  Widget _buildBox(
    BuildContext context,
    NavigationControlData? data,
    NavigationChildControlData? childData,
  ) {
    final box = childData == null
        ? buildBox(context, data, null)
        : RepaintBoundary.wrap(
            buildBox(context, data, childData),
            childData.actualIndex,
          );
    return box;
  }

  Widget buildBox(
    BuildContext context,
    NavigationControlData? data,
    NavigationChildControlData? childData,
  );
}

class _NavigationLabeled extends StatelessWidget {
  final Widget child;
  final Widget label;
  final NavigationLabelPosition position;
  final double spacing;
  final bool showLabel;
  final NavigationLabelType labelType;
  final Axis direction;
  final bool keepCrossAxisSize;
  final bool keepMainAxisSize;

  const _NavigationLabeled({
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
          child: _NavigationChildOverflowHandle(
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

class _NavigationChildOverflowHandle extends StatelessWidget {
  final NavigationOverflow overflow;
  final Widget child;

  const _NavigationChildOverflowHandle({
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
        indent: -_startPadding(parentPadding, direction),
        endIndent: -_endPadding(parentPadding, direction),
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
