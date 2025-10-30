---
title: "Class: ContextMenu"
description: "A widget that shows a context menu when right-clicked or long-pressed."
---

```dart
/// A widget that shows a context menu when right-clicked or long-pressed.
///
/// Wraps a child widget and displays a customizable menu on context menu triggers.
///
/// Example:
/// ```dart
/// ContextMenu(
///   items: [
///     MenuButton(onPressed: (_) => print('Edit'), child: Text('Edit')),
///     MenuButton(onPressed: (_) => print('Delete'), child: Text('Delete')),
///   ],
///   child: Container(child: Text('Right-click me')),
/// )
/// ```
class ContextMenu extends StatefulWidget {
  /// The child widget that triggers the context menu.
  final Widget child;
  /// Menu items to display in the context menu.
  final List<MenuItem> items;
  /// How hit testing behaves for the child.
  final HitTestBehavior behavior;
  /// Direction to lay out menu items.
  final Axis direction;
  /// Whether the context menu is enabled.
  final bool enabled;
  /// Creates a [ContextMenu].
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): Widget that triggers menu.
  /// - [items] (`List<MenuItem>`, required): Menu items.
  /// - [behavior] (`HitTestBehavior`, optional): Hit test behavior.
  /// - [direction] (`Axis`, optional): Menu layout direction.
  /// - [enabled] (`bool`, optional): Whether menu is enabled.
  const ContextMenu({super.key, required this.child, required this.items, this.behavior = HitTestBehavior.translucent, this.direction = Axis.vertical, this.enabled = true});
  State<ContextMenu> createState();
}
```
