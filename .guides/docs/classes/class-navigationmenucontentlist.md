---
title: "Class: NavigationMenuContentList"
description: "A grid layout container for organizing navigation menu content items."
---

```dart
/// A grid layout container for organizing navigation menu content items.
///
/// Provides flexible grid-based layout for multiple [NavigationMenuContent]
/// items within a navigation menu popover. The layout arranges items in
/// columns and rows with customizable spacing and supports responsive
/// organization of navigation options.
///
/// The grid layout adapts to the number of items and specified column count,
/// creating a structured presentation for complex navigation menus with
/// multiple categories or sections of content.
///
/// Example:
/// ```dart
/// NavigationMenuContentList(
///   crossAxisCount: 2,
///   spacing: 16.0,
///   runSpacing: 12.0,
///   children: [
///     NavigationMenuContent(title: Text('Dashboard'), onPressed: _openDashboard),
///     NavigationMenuContent(title: Text('Analytics'), onPressed: _openAnalytics),
///     NavigationMenuContent(title: Text('Settings'), onPressed: _openSettings),
///   ],
/// )
/// ```
class NavigationMenuContentList extends StatelessWidget {
  /// The list of widgets to arrange in the grid layout.
  ///
  /// Typically contains [NavigationMenuContent] items or other
  /// navigation-related widgets that should be organized in a grid.
  final List<Widget> children;
  /// Number of items to display in each row of the grid.
  ///
  /// Controls the grid's column count and affects how items are
  /// distributed across rows. Default value is 3 columns.
  final int crossAxisCount;
  /// Spacing between items within the same row.
  ///
  /// Controls horizontal spacing between grid items. If not specified,
  /// uses a default value based on the theme's scaling factor.
  final double? spacing;
  /// Spacing between rows in the grid.
  ///
  /// Controls vertical spacing between grid rows. If not specified,
  /// uses a default value based on the theme's scaling factor.
  final double? runSpacing;
  /// Whether to reverse the order of columns in each row.
  ///
  /// When true, items are arranged in reverse order within their rows.
  /// This can be useful for RTL layouts or specific design requirements.
  final bool reverse;
  /// Creates a [NavigationMenuContentList] with the specified layout properties.
  ///
  /// The [children] parameter is required and should contain the items
  /// to be arranged in the grid. The layout properties control the
  /// grid's appearance and spacing.
  ///
  /// Parameters:
  /// - [children] (`List<Widget>`, required): Items to arrange in grid
  /// - [crossAxisCount] (int, default: 3): Number of columns per row
  /// - [spacing] (double?, optional): Horizontal spacing between items
  /// - [runSpacing] (double?, optional): Vertical spacing between rows
  /// - [reverse] (bool, default: false): Whether to reverse column order
  ///
  /// Example:
  /// ```dart
  /// NavigationMenuContentList(
  ///   crossAxisCount: 2,
  ///   spacing: 20.0,
  ///   children: menuItems,
  /// )
  /// ```
  const NavigationMenuContentList({super.key, required this.children, this.crossAxisCount = 3, this.spacing, this.runSpacing, this.reverse = false});
  Widget build(BuildContext context);
}
```
