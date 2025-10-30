---
title: "Class: MobileEditableTextContextMenu"
description: "Context menu for editable text fields on mobile platforms."
---

```dart
/// Context menu for editable text fields on mobile platforms.
///
/// Similar to [DesktopEditableTextContextMenu] but optimized for mobile
/// with horizontal layout and no keyboard shortcuts displayed.
///
/// Typically used internally by text input widgets on mobile platforms.
class MobileEditableTextContextMenu extends StatelessWidget {
  /// Build context for positioning the menu.
  final BuildContext anchorContext;
  /// State of the editable text field.
  final EditableTextState editableTextState;
  /// Optional controller for undo/redo functionality.
  final UndoHistoryController? undoHistoryController;
  /// Creates a [MobileEditableTextContextMenu].
  ///
  /// Parameters:
  /// - [anchorContext] (`BuildContext`, required): Anchor context.
  /// - [editableTextState] (`EditableTextState`, required): Text field state.
  /// - [undoHistoryController] (`UndoHistoryController?`, optional): Undo controller.
  const MobileEditableTextContextMenu({super.key, required this.anchorContext, required this.editableTextState, this.undoHistoryController});
  Widget build(BuildContext context);
}
```
