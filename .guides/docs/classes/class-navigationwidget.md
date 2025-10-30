---
title: "Class: NavigationWidget"
description: "Custom widget wrapper for navigation items."
---

```dart
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
  const NavigationWidget({super.key, this.index, required Widget this.child});
  /// Creates a navigation widget with a selection-aware builder.
  ///
  /// Parameters:
  /// - [index] (int?): Selection index
  /// - [builder] (NavigationWidgetBuilder, required): Builder receiving selection state
  const NavigationWidget.builder({super.key, this.index, required NavigationWidgetBuilder this.builder});
  bool get selectable;
  Widget build(BuildContext context);
}
```
