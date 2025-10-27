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
class NavigationBar extends StatefulWidget {
  final Color? backgroundColor;
  final List<NavigationBarItem> children;
  final NavigationBarAlignment? alignment;
  final Axis? direction;
  final double? spacing;
  final NavigationLabelType? labelType;
  final NavigationLabelPosition? labelPosition;
  final NavigationLabelSize? labelSize;
  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;
  final bool? expands;
  final int? index;
  final ValueChanged<int>? onSelected;
  final double? surfaceOpacity;
  final double? surfaceBlur;
  final bool? expanded;
  final bool? keepCrossAxisSize;
  final bool? keepMainAxisSize;
  const NavigationBar({super.key, this.backgroundColor, this.alignment, this.direction, this.spacing, this.labelType, this.labelPosition, this.labelSize, this.padding, this.constraints, this.expands, this.index, this.onSelected, this.surfaceOpacity, this.surfaceBlur, this.expanded, this.keepCrossAxisSize, this.keepMainAxisSize, required this.children});
  State<NavigationBar> createState();
}
```
