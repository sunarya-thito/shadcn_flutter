---
title: "Class: MenuButton"
description: "Clickable button menu item with optional submenu support."
---

```dart
/// Clickable button menu item with optional submenu support.
///
/// Primary menu item type that responds to user interaction. Can display
/// leading icons, trailing widgets (shortcuts), and nested submenus.
///
/// Example:
/// ```dart
/// MenuButton(
///   leading: Icon(Icons.cut),
///   trailing: Text('Ctrl+X').textSmall().muted(),
///   onPressed: (context) => _handleCut(),
///   child: Text('Cut'),
/// )
/// ```
class MenuButton extends StatefulWidget implements MenuItem {
  /// Content widget displayed in the button.
  final Widget child;
  /// Optional submenu items shown on hover or click.
  final List<MenuItem>? subMenu;
  /// Callback when button is pressed.
  final ContextedCallback? onPressed;
  /// Optional trailing widget (e.g., keyboard shortcut indicator).
  final Widget? trailing;
  /// Optional leading widget (e.g., icon).
  final Widget? leading;
  /// Whether the button is enabled for interaction.
  final bool enabled;
  /// Focus node for keyboard navigation.
  final FocusNode? focusNode;
  /// Whether selecting this button closes the menu automatically.
  final bool autoClose;
  final PopoverController? popoverController;
  /// Creates a menu button.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Main content
  /// - [subMenu] (`List<MenuItem>?`): Optional nested submenu
  /// - [onPressed] (ContextedCallback?): Click handler
  /// - [trailing] (Widget?): Trailing widget
  /// - [leading] (Widget?): Leading icon or widget
  /// - [enabled] (bool): Whether enabled, defaults to true
  /// - [focusNode] (FocusNode?): Focus node
  /// - [autoClose] (bool): Auto-close behavior, defaults to true
  /// - [popoverController] (PopoverController?): Optional popover controller
  const MenuButton({super.key, required this.child, this.subMenu, this.onPressed, this.trailing, this.leading, this.enabled = true, this.focusNode, this.autoClose = true, this.popoverController});
  State<MenuButton> createState();
  bool get hasLeading;
}
```
