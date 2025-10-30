---
title: "Class: MenuGroupData"
description: "Data class containing menu group state and configuration."
---

```dart
/// Data class containing menu group state and configuration.
///
/// Manages the hierarchical structure of menu groups, tracking parent-child
/// relationships, popover state, and layout properties. Used internally by
/// the menu system to coordinate behavior across nested menus.
class MenuGroupData {
  /// Parent menu group, null for root menus.
  final MenuGroupData? parent;
  /// Child menu items' data.
  final List<MenuData> children;
  /// Whether any child items have leading widgets.
  final bool hasLeading;
  /// Offset for positioning submenus relative to parent.
  final Offset? subMenuOffset;
  /// Callback when menu is dismissed.
  final VoidCallback? onDismissed;
  /// Region group ID for tap region management.
  final Object? regionGroupId;
  /// Layout direction (horizontal or vertical).
  final Axis direction;
  /// Padding around menu items.
  final EdgeInsets itemPadding;
  /// Focus scope state for keyboard navigation.
  final SubFocusScopeState focusScope;
  /// Creates menu group data.
  ///
  /// Parameters:
  /// - [parent] (MenuGroupData?): Parent group
  /// - [children] (`List<MenuData>`): Child items
  /// - [hasLeading] (bool): Whether items have leading widgets
  /// - [subMenuOffset] (Offset?): Submenu offset
  /// - [onDismissed] (VoidCallback?): Dismissal callback
  /// - [regionGroupId] (Object?): Region group ID
  /// - [direction] (Axis): Layout direction
  /// - [itemPadding] (EdgeInsets): Item padding
  /// - [focusScope] (SubFocusScopeState): Focus scope
  MenuGroupData(this.parent, this.children, this.hasLeading, this.subMenuOffset, this.onDismissed, this.regionGroupId, this.direction, this.itemPadding, this.focusScope);
  /// Checks if any child menu items have open popovers.
  ///
  /// Returns true if at least one child has an open submenu popover.
  bool get hasOpenPopovers;
  /// Closes all open popovers in child menu items.
  ///
  /// Iterates through children and closes any open submenu popovers.
  void closeOthers();
  /// Closes all menus in the hierarchy by bubbling up to root.
  ///
  /// Recursively closes popovers in parent groups and invokes the
  /// dismissal callback at the root level.
  void closeAll();
  bool operator ==(Object other);
  /// Gets the root menu group in the hierarchy.
  ///
  /// Traverses up the parent chain to find the topmost menu group.
  ///
  /// Returns the root [MenuGroupData].
  MenuGroupData get root;
  int get hashCode;
  String toString();
}
```
