---
title: "Class: DesktopEditableTextContextMenu"
description: "Context menu for editable text fields on desktop platforms."
---

```dart
/// Context menu for editable text fields on desktop platforms.
///
/// Provides standard text editing actions like cut, copy, paste, select all,
/// and undo/redo. Automatically integrates with EditableText state.
///
/// Typically used internally by text input widgets.
class DesktopEditableTextContextMenu extends StatelessWidget {
  /// Build context for positioning the menu.
  final BuildContext anchorContext;
  /// State of the editable text field.
  final EditableTextState editableTextState;
  /// Optional controller for undo/redo functionality.
  final UndoHistoryController? undoHistoryController;
  /// Creates a [DesktopEditableTextContextMenu].
  ///
  /// Parameters:
  /// - [anchorContext] (`BuildContext`, required): Anchor context.
  /// - [editableTextState] (`EditableTextState`, required): Text field state.
  /// - [undoHistoryController] (`UndoHistoryController?`, optional): Undo controller.
  const DesktopEditableTextContextMenu({super.key, required this.anchorContext, required this.editableTextState, this.undoHistoryController});
  Widget build(BuildContext context);
}
```
