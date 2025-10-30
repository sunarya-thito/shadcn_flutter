---
title: "Class: DropdownMenu"
description: "A dropdown menu widget that displays a list of menu items in a popup."
---

```dart
/// A dropdown menu widget that displays a list of menu items in a popup.
///
/// Provides a styled dropdown menu with vertical layout, automatic sizing,
/// and theme integration. Wraps menu items in a [MenuPopup] container with
/// appropriate padding and spacing for dropdown contexts.
///
/// Features:
/// - **Vertical Layout**: Displays menu items in a column
/// - **Auto-sizing**: Minimum width constraint of 192px
/// - **Surface Effects**: Configurable backdrop blur and opacity
/// - **Nested Menus**: Supports sub-menus with proper offset
/// - **Sheet Adaptation**: Adjusts padding for sheet overlay contexts
/// - **Auto-dismiss**: Closes when items are selected
///
/// Typically used with [showDropdown] function or as part of dropdown
/// button implementations. Menu items are provided as [MenuItem] widgets.
///
/// Example:
/// ```dart
/// DropdownMenu(
///   children: [
///     MenuItem(
///       title: Text('New File'),
///       leading: Icon(Icons.add),
///       onTap: () => createFile(),
///     ),
///     MenuItem(
///       title: Text('Open'),
///       trailing: Text('Ctrl+O'),
///       onTap: () => openFile(),
///     ),
///     MenuItem.divider(),
///     MenuItem(
///       title: Text('Exit'),
///       onTap: () => exit(),
///     ),
///   ],
/// )
/// ```
///
/// See also:
/// - [MenuItem] for individual menu items
/// - [MenuPopup] for the popup container
/// - [showDropdown] for displaying dropdowns programmatically
class DropdownMenu extends StatefulWidget {
  /// Opacity of the surface blur effect.
  ///
  /// If `null`, uses theme default.
  final double? surfaceOpacity;
  /// Amount of blur to apply to the surface.
  ///
  /// If `null`, uses theme default.
  final double? surfaceBlur;
  /// Menu items to display in the dropdown.
  ///
  /// Each item should be a [MenuItem] or similar menu component.
  final List<MenuItem> children;
  /// Creates a dropdown menu.
  ///
  /// Parameters:
  /// - [children]: Menu items to display (required)
  /// - [surfaceOpacity]: Backdrop blur opacity
  /// - [surfaceBlur]: Amount of surface blur
  const DropdownMenu({super.key, this.surfaceOpacity, this.surfaceBlur, required this.children});
  State<DropdownMenu> createState();
}
```
