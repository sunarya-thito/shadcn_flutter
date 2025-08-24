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
///
/// Example:
/// ```dart
/// NavigationBarTheme(
///   backgroundColor: Colors.blue.shade50,
///   alignment: NavigationBarAlignment.center,
///   spacing: 16.0,
///   labelType: NavigationLabelType.all,
///   padding: EdgeInsets.symmetric(horizontal: 20),
/// );
/// ```
class NavigationBarTheme {
  /// Background color for the navigation bar.
  ///
  /// When null, uses the default theme background color.
  final Color? backgroundColor;
  
  /// Alignment strategy for navigation bar items.
  ///
  /// Determines how navigation items are positioned within the available space.
  final NavigationBarAlignment? alignment;
  
  /// The axis direction for laying out navigation items.
  ///
  /// Typically [Axis.horizontal] for bars and [Axis.vertical] for rails.
  final Axis? direction;
  
  /// Spacing between navigation items.
  ///
  /// Controls the gap between individual navigation elements.
  final double? spacing;
  
  /// Controls which navigation items show labels.
  ///
  /// Determines label visibility behavior across selected/unselected items.
  final NavigationLabelType? labelType;
  
  /// Position of labels relative to navigation icons.
  ///
  /// Controls whether labels appear below, beside, or overlay icons.
  final NavigationLabelPosition? labelPosition;
  
  /// Size category for navigation labels.
  ///
  /// Controls the text size and visual prominence of labels.
  final NavigationLabelSize? labelSize;
  
  /// Internal padding applied to the navigation bar container.
  ///
  /// Controls spacing around the entire navigation content area.
  final EdgeInsetsGeometry? padding;

  /// Creates a [NavigationBarTheme] with optional styling properties.
  ///
  /// Parameters:
  /// - [backgroundColor] (Color?, optional): Navigation bar background color
  /// - [alignment] (NavigationBarAlignment?, optional): Item alignment strategy
  /// - [direction] (Axis?, optional): Layout direction for navigation items  
  /// - [spacing] (double?, optional): Spacing between navigation items
  /// - [labelType] (NavigationLabelType?, optional): Label visibility behavior
  /// - [labelPosition] (NavigationLabelPosition?, optional): Label positioning
  /// - [labelSize] (NavigationLabelSize?, optional): Label size category
  /// - [padding] (EdgeInsetsGeometry?, optional): Container padding
  ///
  /// Example:
  /// ```dart
  /// NavigationBarTheme(
  ///   backgroundColor: theme.colorScheme.surface,
  ///   alignment: NavigationBarAlignment.spaceEvenly,
  ///   spacing: 12.0,
  /// );
  /// ```
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

  /// Creates a copy of this theme with specified properties replaced.
  ///
  /// Each parameter function is called to obtain the new value for that property.
  /// Properties with null functions retain their current values.
  ///
  /// Parameters: Function getters for each theme property to potentially override.
  ///
  /// Returns: A new [NavigationBarTheme] with updated properties.
  ///
  /// Example:
  /// ```dart
  /// final newTheme = currentTheme.copyWith(
  ///   backgroundColor: () => Colors.red,
  ///   spacing: () => 20.0,
  /// );
  /// ```
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

/// Abstract base class for all navigation bar item widgets.
///
/// This class serves as the foundation for widgets that can be placed within
/// a [NavigationBar]. It defines the essential contract that all navigation
/// items must follow, particularly around selection behavior.
///
/// Concrete implementations include [NavigationItem], [NavigationDivider],
/// [NavigationGap], and other specialized navigation components.
///
/// The primary requirement is implementing [selectable] to indicate whether
/// the item can be selected by user interaction and contribute to navigation
/// state management.
abstract class NavigationBarItem extends Widget {
  /// Creates a [NavigationBarItem].
  ///
  /// Parameters:
  /// - [key] (Key?, optional): Widget identifier for efficient updates
  const NavigationBarItem({super.key});

  /// Whether this navigation item can be selected by user interaction.
  ///
  /// Selectable items participate in navigation state management and can
  /// trigger selection callbacks. Non-selectable items (like dividers or
  /// gaps) are purely presentational and don't affect navigation state.
  ///
  /// Returns `true` for interactive navigation items, `false` for decorative elements.
  bool get selectable;
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
class NavigationBar extends StatefulWidget {
  /// Background color for the navigation bar.
  ///
  /// When null, uses the theme's default navigation bar background color.
  final Color? backgroundColor;
  
  /// List of navigation items to display in the bar.
  ///
  /// Can include [NavigationItem], [NavigationDivider], [NavigationGap],
  /// and other [NavigationBarItem] implementations.
  final List<NavigationBarItem> children;
  
  /// Alignment strategy for navigation items within the available space.
  ///
  /// Controls how items are distributed across the navigation container.
  /// Defaults to [NavigationBarAlignment.center].
  final NavigationBarAlignment? alignment;
  
  /// Layout direction for navigation items.
  ///
  /// [Axis.horizontal] for bar-style navigation, [Axis.vertical] for rail-style.
  /// Defaults to [Axis.horizontal].
  final Axis? direction;
  
  /// Spacing between navigation items.
  ///
  /// Controls the gap between individual navigation elements.
  /// Scales with the current theme scaling factor.
  final double? spacing;
  
  /// Controls which navigation items display labels.
  ///
  /// Determines label visibility behavior (all, selected only, none).
  /// Defaults to [NavigationLabelType.none].
  final NavigationLabelType? labelType;
  
  /// Position of labels relative to navigation icons.
  ///
  /// Controls whether labels appear below, beside, or overlay icons.
  /// Defaults to [NavigationLabelPosition.bottom].
  final NavigationLabelPosition? labelPosition;
  
  /// Size category for navigation labels.
  ///
  /// Controls the text size and visual prominence of labels.
  /// Defaults to [NavigationLabelSize.small].
  final NavigationLabelSize? labelSize;
  
  /// Internal padding applied to the navigation container.
  ///
  /// Controls spacing around the entire navigation content area.
  final EdgeInsetsGeometry? padding;
  
  /// Box constraints applied to the navigation container.
  ///
  /// Used to control the overall size and layout behavior of the navigation bar.
  final BoxConstraints? constraints;
  
  /// Whether the navigation bar should expand to fill available space.
  ///
  /// When true, the navigation bar takes up all available space in its parent.
  final bool? expands;
  
  /// Currently selected navigation item index.
  ///
  /// Used for highlighting the active navigation item. Can be null for no selection.
  final int? index;
  
  /// Callback invoked when a navigation item is selected.
  ///
  /// Receives the index of the selected navigation item.
  final ValueChanged<int>? onSelected;
  
  /// Opacity level for surface blur effects.
  ///
  /// Controls the transparency of glassmorphism background effects.
  /// Values from 0.0 (transparent) to 1.0 (opaque).
  final double? surfaceOpacity;
  
  /// Blur intensity for surface effects.
  ///
  /// Controls the gaussian blur strength for glassmorphism styling.
  /// Higher values create more blur effect.
  final double? surfaceBlur;
  
  /// Whether the navigation bar is in expanded state.
  ///
  /// Affects layout and presentation of navigation items.
  final bool? expanded;
  
  /// Whether to maintain cross-axis size during layout.
  ///
  /// Controls sizing behavior perpendicular to the main layout direction.
  final bool? keepCrossAxisSize;
  
  /// Whether to maintain main-axis size during layout.
  ///
  /// Controls sizing behavior along the primary layout direction.
  final bool? keepMainAxisSize;

  /// Creates a [NavigationBar] with the specified configuration.
  ///
  /// Parameters:
  /// - [children] (List<NavigationBarItem>, required): Navigation items to display
  /// - [backgroundColor] (Color?, optional): Navigation bar background color
  /// - [alignment] (NavigationBarAlignment?, optional): Item alignment strategy
  /// - [direction] (Axis?, optional): Layout direction for navigation items
  /// - [spacing] (double?, optional): Spacing between navigation items
  /// - [labelType] (NavigationLabelType?, optional): Label visibility behavior
  /// - [labelPosition] (NavigationLabelPosition?, optional): Label positioning
  /// - [labelSize] (NavigationLabelSize?, optional): Label size category
  /// - [padding] (EdgeInsetsGeometry?, optional): Container padding
  /// - [constraints] (BoxConstraints?, optional): Container size constraints
  /// - [expands] (bool?, optional): Whether to fill available space
  /// - [index] (int?, optional): Currently selected item index
  /// - [onSelected] (ValueChanged<int>?, optional): Selection change callback
  /// - [surfaceOpacity] (double?, optional): Glassmorphism opacity level
  /// - [surfaceBlur] (double?, optional): Glassmorphism blur intensity
  /// - [expanded] (bool?, optional): Whether navigation is in expanded state
  /// - [keepCrossAxisSize] (bool?, optional): Maintain cross-axis sizing
  /// - [keepMainAxisSize] (bool?, optional): Maintain main-axis sizing
  ///
  /// Example:
  /// ```dart
  /// NavigationBar(
  ///   index: selectedIndex,
  ///   onSelected: (index) => _handleSelection(index),
  ///   alignment: NavigationBarAlignment.spaceEvenly,
  ///   labelType: NavigationLabelType.all,
  ///   children: [
  ///     NavigationItem(icon: Icons.home, label: Text('Home')),
  ///     NavigationItem(icon: Icons.search, label: Text('Search')),
  ///   ],
  /// );
  /// ```
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
    this.constraints,
    this.expands,
    this.index,
    this.onSelected,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.expanded,
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
      defaultValue: 8 * scaling,
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
    final parentPadding = styleValue(
      widgetValue: widget.padding,
      themeValue: compTheme?.padding,
      defaultValue:
          const EdgeInsets.symmetric(vertical: 8, horizontal: 12) * scaling,
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
    return AppBar(
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

mixin NavigationContainerMixin {
  List<Widget> wrapChildren(
    BuildContext context,
    List<NavigationBarItem> children,
  ) {
    int index = 0;
    List<Widget> newChildren = List.of(children);
    for (var i = 0; i < children.length; i++) {
      if (children[i].selectable) {
        newChildren[i] = Data.inherit(
          data: NavigationChildControlData(index: index, actualIndex: i),
          child: children[i],
        );
        index++;
      } else {
        newChildren[i] = Data.inherit(
          data: NavigationChildControlData(index: null, actualIndex: i),
          child: children[i],
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
  final List<NavigationBarItem> children;

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

  /// Index of the currently selected navigation item.
  ///
  /// Highlights the corresponding item and affects label display based
  /// on the [labelType] setting. When null, no item is selected.
  final int? index;

  /// Callback invoked when a navigation item is selected.
  ///
  /// Called with the index of the tapped item. Use this to update
  /// the selected index and navigate to the corresponding destination.
  final ValueChanged<int>? onSelected;

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
  /// - [children] (List<NavigationBarItem>, required): Navigation destinations
  /// - [alignment] (NavigationRailAlignment, default: center): Item alignment along main axis
  /// - [direction] (Axis, default: vertical): Layout orientation of the rail
  /// - [labelType] (NavigationLabelType, default: selected): When to show labels
  /// - [labelPosition] (NavigationLabelPosition, default: bottom): Label positioning
  /// - [index] (int?, optional): Currently selected item index
  /// - [onSelected] (ValueChanged<int>?, optional): Selection change callback
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
    this.index,
    this.onSelected,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.expanded = true,
    this.keepMainAxisSize = false,
    this.keepCrossAxisSize = false,
    required this.children,
  });

  @override
  State<NavigationRail> createState() => _NavigationRailState();
}

class _NavigationRailState extends State<NavigationRail>
    with NavigationContainerMixin {
  AlignmentGeometry get _alignment {
    switch ((widget.alignment, widget.direction)) {
      case (NavigationRailAlignment.start, Axis.horizontal):
        return AlignmentDirectional.centerStart;
      case (NavigationRailAlignment.center, Axis.horizontal):
        return AlignmentDirectional.topCenter;
      case (NavigationRailAlignment.end, Axis.horizontal):
        return AlignmentDirectional.centerEnd;
      case (NavigationRailAlignment.start, Axis.vertical):
        return AlignmentDirectional.topCenter;
      case (NavigationRailAlignment.center, Axis.vertical):
        return AlignmentDirectional.center;
      case (NavigationRailAlignment.end, Axis.vertical):
        return AlignmentDirectional.bottomCenter;
    }
  }

  void _onSelected(int index) {
    widget.onSelected?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    var parentPadding = widget.padding ??
        (const EdgeInsets.symmetric(vertical: 8, horizontal: 12) * scaling);
    var directionality = Directionality.of(context);
    var resolvedPadding = parentPadding.resolve(directionality);
    return RepaintBoundary(
      child: Data.inherit(
        data: NavigationControlData(
          containerType: NavigationContainerType.rail,
          parentLabelType: widget.labelType,
          parentLabelPosition: widget.labelPosition,
          parentLabelSize: widget.labelSize,
          parentPadding: resolvedPadding,
          direction: widget.direction,
          selectedIndex: widget.index,
          onSelected: _onSelected,
          expanded: widget.expanded,
          childCount: widget.children.length,
          spacing: widget.spacing ?? (8 * scaling),
          keepCrossAxisSize: widget.keepCrossAxisSize,
          keepMainAxisSize: widget.keepMainAxisSize,
        ),
        child: SurfaceBlur(
          surfaceBlur: widget.surfaceBlur,
          child: Container(
            color: widget.backgroundColor ??
                (theme.colorScheme.background.scaleAlpha(
                  widget.surfaceOpacity ?? 1,
                )),
            alignment: _alignment,
            child: SingleChildScrollView(
              scrollDirection: widget.direction,
              padding: resolvedPadding,
              child: _wrapIntrinsic(
                Flex(
                  direction: widget.direction,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: wrapChildren(context, widget.children),
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
  /// - [children] (List<NavigationBarItem>, required): Navigation destinations
  /// - [labelType] (NavigationLabelType, default: expanded): Label display behavior
  /// - [labelPosition] (NavigationLabelPosition, default: end): Label positioning
  /// - [labelSize] (NavigationLabelSize, default: large): Size variant for items
  /// - [index] (int?, optional): Currently selected item index
  /// - [onSelected] (ValueChanged<int>?, optional): Selection change callback
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
    List<Widget> children = wrapChildren(context, widget.children);
    var parentPadding = widget.padding ??
        (const EdgeInsets.symmetric(vertical: 8, horizontal: 12) * scaling);
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
        childCount: children.length,
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
                child: CustomScrollView(
                  clipBehavior: Clip.none,
                  shrinkWrap: true,
                  scrollDirection: direction,
                  slivers: [
                    SliverGap(_startPadding(resolvedPadding, direction)),
                    ...children.map((e) {
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
            ),
          ),
        ),
      ),
    );
  }
}

enum NavigationLabelType { none, selected, all, tooltip, expanded }

enum NavigationLabelPosition { start, end, top, bottom }

enum NavigationLabelSize { small, large }

class NavigationChildControlData {
  final int? index;
  final int actualIndex;

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

class NavigationControlData {
  final NavigationContainerType containerType;
  final NavigationLabelType parentLabelType;
  final NavigationLabelPosition parentLabelPosition;
  final NavigationLabelSize parentLabelSize;
  final EdgeInsets parentPadding;
  final Axis direction;
  final int? selectedIndex;
  final int childCount;
  final ValueChanged<int> onSelected;
  final bool expanded;
  final double spacing;
  final bool keepCrossAxisSize;
  final bool keepMainAxisSize;

  Axis get labelDirection {
    return parentLabelPosition == NavigationLabelPosition.start ||
            parentLabelPosition == NavigationLabelPosition.end
        ? Axis.horizontal
        : Axis.vertical;
  }

  NavigationControlData({
    required this.containerType,
    required this.parentLabelType,
    required this.parentLabelPosition,
    required this.parentLabelSize,
    required this.parentPadding,
    required this.direction,
    required this.selectedIndex,
    required this.onSelected,
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

class NavigationGap extends StatelessWidget implements NavigationBarItem {
  final double gap;

  const NavigationGap(this.gap, {super.key});

  @override
  bool get selectable => false;

  Widget buildBox(BuildContext context) {
    return Gap(gap);
  }

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

class NavigationDivider extends StatelessWidget implements NavigationBarItem {
  final double? thickness;
  final Color? color;

  const NavigationDivider({super.key, this.thickness, this.color});

  @override
  bool get selectable => false;

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
              ? EdgeInsets.symmetric(vertical: 8 * scaling)
              : EdgeInsets.symmetric(horizontal: 8 * scaling),
          child: child,
        ),
      );
    }
    return Padding(
      padding: direction == Axis.vertical
          ? EdgeInsets.symmetric(vertical: 4 * scaling)
          : EdgeInsets.symmetric(horizontal: 4 * scaling),
      child: child,
    );
  }
}

class NavigationItem extends AbstractNavigationButton {
  final AbstractButtonStyle? selectedStyle;
  final bool? selected;
  final ValueChanged<bool>? onChanged;
  final int? index;
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
  bool get selectable {
    // if index is not null, then the child itself handles the selection
    // if index is null, then the parent handles the selection
    return index == null;
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
                data?.onSelected(parentIndex ?? widget.index!);
              }
            : widget.onChanged,
        marginAlignment: widget.marginAlignment,
        style: style,
        selectedStyle: selectedStyle,
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
          spacing: widget.spacing ?? (8 * scaling),
          child: widget.child,
        ),
      ),
    );
  }
}

class NavigationButton extends AbstractNavigationButton {
  final VoidCallback? onPressed;
  const NavigationButton({
    super.key,
    this.onPressed,
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
  bool get selectable {
    return false;
  }

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
          spacing: widget.spacing ?? (8 * scaling),
          child: widget.child,
        ),
      ),
    );
  }
}

abstract class AbstractNavigationButton extends StatefulWidget
    implements NavigationBarItem {
  final Widget child;
  final Widget? label;
  final double? spacing;
  final AbstractButtonStyle? style;
  final AlignmentGeometry? alignment;

  final bool? enabled;
  final NavigationOverflow overflow;
  final AlignmentGeometry? marginAlignment;

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
    if (childData == null) {
      return buildBox(context, data, null);
    } else {
      return RepaintBoundary.wrap(
        buildBox(context, data, childData),
        childData.actualIndex,
      );
    }
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
      reverse: position == NavigationLabelPosition.start ||
          position == NavigationLabelPosition.top,
      keepCrossAxisSize:
          (this.direction != direction ? keepCrossAxisSize : keepMainAxisSize),
      keepMainAxisSize:
          (this.direction != direction ? keepMainAxisSize : keepCrossAxisSize),
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          top: position == NavigationLabelPosition.bottom ? spacing : 0,
          bottom: position == NavigationLabelPosition.top ? spacing : 0,
          start: position == NavigationLabelPosition.end ? spacing : 0,
          end: position == NavigationLabelPosition.start ? spacing : 0,
        ),
        child: label,
      ),
    );
    return IntrinsicHeight(
      child: IntrinsicWidth(
        child: Flex(
          direction: direction,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (position == NavigationLabelPosition.start ||
                position == NavigationLabelPosition.top)
              Flexible(child: animatedSize),
            child,
            if (position == NavigationLabelPosition.end ||
                position == NavigationLabelPosition.bottom)
              Flexible(child: animatedSize),
          ],
        ),
      ),
    );
  }
}

class NavigationPadding extends StatelessWidget {
  final Widget child;

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

enum NavigationOverflow { clip, marquee, ellipsis, none }

class NavigationLabel extends StatelessWidget implements NavigationBarItem {
  final Widget child;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final NavigationOverflow overflow;

  // these options are ignored in NavigationBar and NavigationRail
  final bool floating;
  final bool pinned;

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
  bool get selectable => false;

  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<NavigationControlData>(context);
    if (data?.containerType == NavigationContainerType.sidebar) {
      return buildSliver(context, data);
    }
    return buildBox(context, data);
  }

  Widget buildChild(BuildContext context, NavigationControlData? data) {
    bool expanded = data?.expanded ?? true;
    return Hidden(
      hidden: !expanded,
      direction: data?.direction ?? Axis.vertical,
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

  Widget buildBox(BuildContext context, NavigationControlData? data) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return DefaultTextStyle.merge(
      textAlign: TextAlign.center,
      child: Container(
        alignment: alignment ?? Alignment.center,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 8 * scaling),
        child: buildChild(context, data).xSmall(),
      ),
    );
  }

  Widget buildSliver(BuildContext context, NavigationControlData? data) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
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
            maxExtent: 48 * scaling * value,
            minExtent: 48 * scaling * value,
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
                padding:
                    padding ?? EdgeInsets.symmetric(horizontal: 16 * scaling),
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

typedef NavigationWidgetBuilder = Widget Function(
    BuildContext context, bool selected);

class NavigationWidget extends StatelessWidget implements NavigationBarItem {
  final int? index;
  final Widget? child;
  final NavigationWidgetBuilder? builder;

  const NavigationWidget({super.key, this.index, required Widget this.child})
      : builder = null;

  const NavigationWidget.builder({
    super.key,
    this.index,
    required NavigationWidgetBuilder this.builder,
  }) : child = null;

  @override
  bool get selectable {
    return index == null;
  }

  @override
  Widget build(BuildContext context) {
    var data = Data.maybeOf<NavigationControlData>(context);
    var childData = Data.maybeOf<NavigationChildControlData>(context);
    var index = childData?.index ?? this.index;
    var isSelected = index == data?.selectedIndex;
    return child ?? builder!(context, isSelected);
  }
}
