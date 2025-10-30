---
title: "Class: CommandItem"
description: "An individual selectable item in a command palette."
---

```dart
/// An individual selectable item in a command palette.
///
/// Represents a single command or option that can be selected via click or
/// keyboard navigation. Supports optional leading and trailing widgets for
/// icons, shortcuts, or other decorations.
///
/// ## Example
///
/// ```dart
/// CommandItem(
///   leading: Icon(Icons.save),
///   title: Text('Save File'),
///   trailing: Text('Ctrl+S'),
///   onTap: () => saveFile(),
/// )
/// ```
class CommandItem extends StatefulWidget {
  /// Optional widget displayed before the title (e.g., an icon).
  final Widget? leading;
  /// The main title/label of the command item.
  final Widget title;
  /// Optional widget displayed after the title (e.g., keyboard shortcut).
  final Widget? trailing;
  /// Called when the item is selected/tapped.
  final VoidCallback? onTap;
  /// Creates a [CommandItem] for display in a command palette.
  ///
  /// Parameters:
  /// - [title] (Widget, required): The main label for this command
  /// - [leading] (Widget?, optional): Widget displayed before the title (e.g., icon)
  /// - [trailing] (Widget?, optional): Widget displayed after the title (e.g., shortcut)
  /// - [onTap] (VoidCallback?, optional): Callback when the item is selected
  ///
  /// Example:
  /// ```dart
  /// CommandItem(
  ///   leading: Icon(Icons.file_copy),
  ///   title: Text('Duplicate'),
  ///   trailing: Text('Ctrl+D'),
  ///   onTap: () => duplicate(),
  /// )
  /// ```
  const CommandItem({super.key, this.leading, required this.title, this.trailing, this.onTap});
  State<CommandItem> createState();
}
```
