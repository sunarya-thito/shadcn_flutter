---
title: "Class: TreeItemView"
description: "A comprehensive tree item widget with interaction, expansion, and selection support."
---

```dart
/// A comprehensive tree item widget with interaction, expansion, and selection support.
///
/// TreeItemView provides a complete tree item interface that handles user
/// interaction, visual feedback, expansion/collapse behavior, and keyboard
/// navigation. It's designed to work within a TreeView context but can be
/// used independently for custom tree implementations.
///
/// The widget supports both single and double-click interactions, optional
/// leading and trailing widgets, expandable content, and focus management.
/// It automatically integrates with the tree's selection and expansion state
/// when used within a TreeView.
///
/// Features:
/// - Click and double-click interaction support
/// - Optional expand/collapse functionality for nodes with children
/// - Leading and trailing widget support for icons or actions
/// - Keyboard navigation with arrow keys and space bar
/// - Visual selection feedback with customizable styling
/// - Focus management and accessibility support
/// - Integration with tree branch lines and indentation
///
/// The widget automatically applies appropriate styling based on selection state,
/// focus state, and tree depth. It handles the visual representation of tree
/// hierarchy through indentation and branch line integration.
///
/// Example:
/// ```dart
/// TreeItemView(
///   leading: Icon(isDirectory ? Icons.folder : Icons.insert_drive_file),
///   trailing: PopupMenuButton(items: contextMenuItems),
///   expandable: hasChildren,
///   onPressed: () => selectItem(item),
///   onDoublePressed: () => openItem(item),
///   onExpand: (expanded) => toggleExpansion(item, expanded),
///   child: Text(item.name),
/// )
/// ```
class TreeItemView extends StatefulWidget {
  /// The main content widget for this tree item.
  ///
  /// Type: `Widget`. This widget represents the primary content of the tree item,
  /// typically text or a combination of text and icons.
  final Widget child;
  /// Optional widget displayed at the leading edge of the item.
  ///
  /// Type: `Widget?`. Commonly used for icons that represent the item type,
  /// such as folder or file icons. Positioned before the main content.
  final Widget? leading;
  /// Optional widget displayed at the trailing edge of the item.
  ///
  /// Type: `Widget?`. Commonly used for action buttons, status indicators,
  /// or context menus. Positioned after the main content.
  final Widget? trailing;
  /// Callback invoked when the tree item is pressed/clicked.
  ///
  /// Type: `VoidCallback?`. Called for single-click interactions. If null,
  /// the item will not respond to press gestures.
  final VoidCallback? onPressed;
  /// Callback invoked when the tree item is double-pressed/double-clicked.
  ///
  /// Type: `VoidCallback?`. Called for double-click interactions. If null,
  /// the item will not respond to double-click gestures.
  final VoidCallback? onDoublePressed;
  /// Callback invoked when the expand/collapse state should change.
  ///
  /// Type: `ValueChanged<bool>?`. Called with the desired expansion state
  /// when the user interacts with expand controls or uses keyboard shortcuts.
  final ValueChanged<bool>? onExpand;
  /// Whether this item can be expanded to show children.
  ///
  /// Type: `bool?`. If null, determined automatically based on whether the
  /// tree node has children. When true, expand/collapse controls are shown.
  final bool? expandable;
  /// Optional focus node for keyboard navigation and focus management.
  ///
  /// Type: `FocusNode?`. If null, a focus node is created automatically.
  /// Allows external control of focus state for this tree item.
  final FocusNode? focusNode;
  /// Creates a [TreeItemView] with comprehensive tree item functionality.
  ///
  /// Configures a tree item widget with interaction support, optional expansion,
  /// and customizable leading/trailing elements.
  ///
  /// Parameters:
  /// - [key] (Key?): Widget identifier for the widget tree
  /// - [child] (Widget, required): Main content widget for the tree item
  /// - [leading] (Widget?, optional): Widget displayed before the content
  /// - [trailing] (Widget?, optional): Widget displayed after the content
  /// - [onPressed] (VoidCallback?, optional): Callback for press/click events
  /// - [onDoublePressed] (VoidCallback?, optional): Callback for double-click events
  /// - [onExpand] (`ValueChanged<bool>?`, optional): Callback for expansion changes
  /// - [expandable] (bool?, optional): Whether the item can be expanded
  /// - [focusNode] (FocusNode?, optional): Focus node for keyboard navigation
  ///
  /// Example:
  /// ```dart
  /// TreeItemView(
  ///   leading: Icon(Icons.folder),
  ///   trailing: Badge(child: Text('3')),
  ///   expandable: true,
  ///   onPressed: () => handleSelection(),
  ///   onDoublePressed: () => handleOpen(),
  ///   onExpand: (expanded) => handleExpansion(expanded),
  ///   child: Text('Project Folder'),
  /// )
  /// ```
  const TreeItemView({super.key, required this.child, this.leading, this.trailing, this.onPressed, this.onDoublePressed, this.onExpand, this.expandable, this.focusNode});
  State<TreeItemView> createState();
}
```
