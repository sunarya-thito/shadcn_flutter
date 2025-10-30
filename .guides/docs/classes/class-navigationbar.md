---
title: "Class: NavigationBar"
description: "A flexible navigation container widget for organizing navigation items."
---

```dart
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
  /// Size constraints for the navigation bar.
  final BoxConstraints? constraints;
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
  /// Whether to keep cross-axis size when expanding/collapsing.
  final bool? keepCrossAxisSize;
  /// Whether to keep main-axis size when expanding/collapsing.
  final bool? keepMainAxisSize;
  /// Creates a [NavigationBar].
  const NavigationBar({super.key, this.backgroundColor, this.alignment, this.direction, this.spacing, this.labelType, this.labelPosition, this.labelSize, this.padding, this.constraints, this.expands, this.index, this.onSelected, this.surfaceOpacity, this.surfaceBlur, this.expanded, this.keepCrossAxisSize, this.keepMainAxisSize, required this.children});
  State<NavigationBar> createState();
}
```
