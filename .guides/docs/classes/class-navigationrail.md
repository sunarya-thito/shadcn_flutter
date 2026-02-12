---
title: "Class: NavigationRail"
description: "A standard navigation rail component for sidebar-style navigation.   Provides a compact vertical navigation bar (rail) typically used on the side  of a screen. It can be configured with or without labels, support multiple  alignment modes, and manage its own selection state. Navigation items  are defined through the [children] and [footer] properties.   Features:  - Supports both vertical and horizontal orientations  - Configurable alignment (start, center, end)  - Flexible label display modes (always, never, selected)  - Optional header and footer sections  - Built-in expansion and collapse animations  - Customizable background, surface effects, and constraints   Example:  ```dart  NavigationRail(    selectedKey: ValueKey('home'),    onSelected: (key) => setState(() => selectedKey = key),    children: [      NavigationItem(        key: ValueKey('home'),        icon: Icon(Icons.home),        label: Text('Home'),      ),      NavigationItem(        key: ValueKey('search'),        icon: Icon(Icons.search),        label: Text('Search'),      ),    ],  )  ```"
---

```dart
/// A standard navigation rail component for sidebar-style navigation.
///
/// Provides a compact vertical navigation bar (rail) typically used on the side
/// of a screen. It can be configured with or without labels, support multiple
/// alignment modes, and manage its own selection state. Navigation items
/// are defined through the [children] and [footer] properties.
///
/// Features:
/// - Supports both vertical and horizontal orientations
/// - Configurable alignment (start, center, end)
/// - Flexible label display modes (always, never, selected)
/// - Optional header and footer sections
/// - Built-in expansion and collapse animations
/// - Customizable background, surface effects, and constraints
///
/// Example:
/// ```dart
/// NavigationRail(
///   selectedKey: ValueKey('home'),
///   onSelected: (key) => setState(() => selectedKey = key),
///   children: [
///     NavigationItem(
///       key: ValueKey('home'),
///       icon: Icon(Icons.home),
///       label: Text('Home'),
///     ),
///     NavigationItem(
///       key: ValueKey('search'),
///       icon: Icon(Icons.search),
///       label: Text('Search'),
///     ),
///   ],
/// )
/// ```
class NavigationRail extends StatefulWidget {
  /// Background color of the navigation rail.
  final Color? backgroundColor;
  /// Alignment of navigation items along the main axis.
  final NavigationRailAlignment alignment;
  /// Layout direction (horizontal or vertical).
  final Axis direction;
  /// Spacing between navigation items.
  final double? spacing;
  /// Type of label display behavior.
  final NavigationLabelType labelType;
  /// Position of labels relative to icons.
  final NavigationLabelPosition labelPosition;
  /// Size variant for labels.
  final NavigationLabelSize labelSize;
  /// Internal padding of the navigation rail.
  final EdgeInsetsGeometry? padding;
  /// Constraints for the navigation rail container.
  final BoxConstraints? constraints;
  /// Cross-axis size when the rail is expanded.
  final double? expandedSize;
  /// Cross-axis size when the rail is collapsed.
  final double? collapsedSize;
  /// Surface opacity effect for the background.
  final double? surfaceOpacity;
  /// Surface blur effect for the background.
  final double? surfaceBlur;
  /// Whether the rail is in its expanded state.
  final bool expanded;
  /// Whether to maintain intrinsic size along the main axis.
  final bool keepMainAxisSize;
  /// Whether to maintain intrinsic size along the cross axis.
  final bool keepCrossAxisSize;
  /// Optional header widget displayed at the start of the rail.
  final List<Widget>? header;
  /// Optional footer widget displayed at the end of the rail.
  final List<Widget>? footer;
  /// List of navigation items to display.
  final List<Widget> children;
  /// Currently selected item key.
  final Key? selectedKey;
  /// Callback when an item is selected.
  final ValueChanged<Key?>? onSelected;
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
  /// - [children] (`List<Widget>`, required): Navigation destinations
  /// - [alignment] (NavigationRailAlignment, default: center): Item alignment along main axis
  /// - [direction] (Axis, default: vertical): Layout orientation of the rail
  /// - [labelType] (NavigationLabelType, default: selected): When to show labels
  /// - [labelPosition] (NavigationLabelPosition, default: bottom): Label positioning
  /// - [selectedKey] (Key?, optional): Currently selected item key
  /// - [onSelected] (`ValueChanged<Key?>?`, optional): Selection change callback
  const NavigationRail({super.key, this.backgroundColor, this.alignment = NavigationRailAlignment.center, this.direction = Axis.vertical, this.spacing, this.labelType = NavigationLabelType.selected, this.labelPosition = NavigationLabelPosition.bottom, this.labelSize = NavigationLabelSize.small, this.padding, this.constraints, this.expandedSize, this.collapsedSize, this.surfaceOpacity, this.surfaceBlur, this.expanded = true, this.keepMainAxisSize = false, this.keepCrossAxisSize = false, this.header, this.footer, this.selectedKey, this.onSelected, required this.children});
  State<NavigationRail> createState();
}
```
