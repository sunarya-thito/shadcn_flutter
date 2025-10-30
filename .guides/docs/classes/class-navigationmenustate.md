---
title: "Class: NavigationMenuState"
description: "State class for [NavigationMenu] managing menu interactions and timing."
---

```dart
/// State class for [NavigationMenu] managing menu interactions and timing.
///
/// Handles hover debouncing, popover control, active menu item tracking,
/// and content builder management for navigation menu items.
class NavigationMenuState extends State<NavigationMenu> {
  /// Debounce duration for hover interactions to prevent flickering.
  static const Duration kDebounceDuration = Duration(milliseconds: 200);
  /// Checks if the given menu item is currently active.
  ///
  /// Parameters:
  /// - [item] (`NavigationMenuItemState`, required): the menu item to check
  ///
  /// Returns: `bool` — true if the item is active and popover is open
  bool isActive(NavigationMenuItemState item);
  void dispose();
  /// Finds a navigation menu item state by its widget.
  ///
  /// Parameters:
  /// - [widget] (`Widget`, required): the widget to search for
  ///
  /// Returns: `NavigationMenuItemState?` — the state if found, null otherwise
  NavigationMenuItemState? findByWidget(Widget widget);
  /// Builds the content for the menu item at the given index.
  ///
  /// Parameters:
  /// - [index] (`int`, required): index of the menu item
  ///
  /// Returns: `Widget` — the content widget
  Widget buildContent(int index);
  /// Closes the currently open popover menu.
  void close();
  /// Builds the popover widget for the navigation menu.
  ///
  /// Parameters:
  /// - [context] (`BuildContext`, required): build context
  ///
  /// Returns: `Widget` — the popover widget
  Widget buildPopover(BuildContext context);
  /// Calculates the margin for the popover based on current widget position.
  ///
  /// Returns: `EdgeInsets?` — calculated margin or null if render box not available
  EdgeInsets? requestMargin();
  Widget build(BuildContext context);
}
```
