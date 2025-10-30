---
title: "Class: ContextMenuPopup"
description: "Internal widget for rendering a context menu popup."
---

```dart
/// Internal widget for rendering a context menu popup.
///
/// Displays the actual menu content in an overlay with positioning and theming.
/// Typically used internally by [ContextMenu].
class ContextMenuPopup extends StatelessWidget {
  /// Build context for anchoring the popup.
  final BuildContext anchorContext;
  /// Position to display the popup.
  final Offset position;
  /// Menu items to display.
  final List<MenuItem> children;
  /// Captured themes for consistent styling.
  final CapturedThemes? themes;
  /// Direction to lay out menu items.
  final Axis direction;
  /// Callback when popup follows the anchor.
  final ValueChanged<PopoverOverlayWidgetState>? onTickFollow;
  /// Size of the anchor widget.
  final Size? anchorSize;
  /// Creates a [ContextMenuPopup].
  ///
  /// Parameters:
  /// - [anchorContext] (`BuildContext`, required): Anchor context.
  /// - [position] (`Offset`, required): Popup position.
  /// - [children] (`List<MenuItem>`, required): Menu items.
  /// - [themes] (`CapturedThemes?`, optional): Captured themes.
  /// - [direction] (`Axis`, default: `Axis.vertical`): Layout direction.
  /// - [onTickFollow] (`ValueChanged<PopoverOverlayWidgetState>?`, optional): Follow callback.
  /// - [anchorSize] (`Size?`, optional): Anchor size.
  const ContextMenuPopup({super.key, required this.anchorContext, required this.position, required this.children, this.themes, this.direction = Axis.vertical, this.onTickFollow, this.anchorSize});
  Widget build(BuildContext context);
}
```
