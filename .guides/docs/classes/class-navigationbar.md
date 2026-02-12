---
title: "Class: NavigationBar"
description: "A flexible navigation container widget for organizing navigation items.   [NavigationBar] provides a comprehensive navigation solution that can be configured  for various layouts including horizontal bars, vertical rails, and expandable sidebars.  It manages navigation item presentation, selection states, and provides extensive  customization options for different navigation patterns.   Key features:  - Flexible layout orientation (horizontal/vertical)  - Multiple alignment strategies for item positioning  - Configurable label presentation and positioning  - Selection state management with callbacks  - Surface effects for glassmorphism styling  - Responsive behavior with expansion options  - Theme integration for consistent styling  - Support for gaps, dividers, and custom widgets   Navigation layout modes:  - **Bar**: Standard horizontal or vertical bar with items arranged linearly.  - **Rail**: Compact sidebar-style navigation typically used on screen edges.  - **Sidebar**: Full-featured expandable sidebar for complex navigation hierarchies."
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
/// - **Bar**: Standard horizontal or vertical bar with items arranged linearly.
/// - **Rail**: Compact sidebar-style navigation typically used on screen edges.
/// - **Sidebar**: Full-featured expandable sidebar for complex navigation hierarchies.
class NavigationBar extends StatefulWidget {
  /// The list of navigation items, dividers, or gaps to display.
  final List<Widget> children;
  /// The alignment of items within the navigation bar.
  final NavigationBarAlignment alignment;
  /// The layout orientation of the navigation bar.
  ///
  /// If null, defaults to [Axis.horizontal].
  final Axis? direction;
  /// When labels should be displayed for the items.
  final NavigationLabelType labelType;
  /// The relative position of labels to their corresponding icons.
  final NavigationLabelPosition labelPosition;
  /// The size variant for label text.
  final NavigationLabelSize labelSize;
  /// The background color of the navigation bar.
  final Color? backgroundColor;
  /// Internal padding for the navigation bar content.
  final EdgeInsetsGeometry? padding;
  /// Opacity of the background surface (0.0 to 1.0).
  final double? surfaceOpacity;
  /// Blur intensity for glassmorphic surface effects.
  final double? surfaceBlur;
  /// The key of the currently selected navigation item.
  final Key? selectedKey;
  /// Callback invoked when a navigation item selection changes.
  final ValueChanged<Key?>? onSelected;
  /// Whether the navigation bar should expand to fill available space.
  final bool expanded;
  /// Whether to maintain the cross-axis size based on intrinsic content size.
  final bool? keepCrossAxisSize;
  /// Whether to maintain the main-axis size based on intrinsic content size.
  final bool? keepMainAxisSize;
  /// Cross-axis size when the bar is in an expanded state.
  final double? expandedSize;
  /// Cross-axis size when the bar is in a collapsed state.
  final double? collapsedSize;
  /// The spacing between navigation items.
  final double? spacing;
  /// Creates a [NavigationBar] with the specified configuration.
  const NavigationBar({super.key, required this.children, this.alignment = NavigationBarAlignment.start, this.direction, this.labelType = NavigationLabelType.all, this.labelPosition = NavigationLabelPosition.bottom, this.labelSize = NavigationLabelSize.small, this.backgroundColor, this.padding, this.surfaceOpacity, this.surfaceBlur, this.selectedKey, this.onSelected, this.expanded = false, this.keepCrossAxisSize, this.keepMainAxisSize, this.expandedSize, this.collapsedSize, this.spacing});
  State<NavigationBar> createState();
}
```
