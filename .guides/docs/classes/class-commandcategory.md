---
title: "Class: CommandCategory"
description: "A category grouping for command items in a command palette."
---

```dart
/// A category grouping for command items in a command palette.
///
/// Groups related command items under an optional category title. Items within
/// a category are visually grouped and can be navigated as a unit.
///
/// ## Example
///
/// ```dart
/// CommandCategory(
///   title: Text('File'),
///   children: [
///     CommandItem(title: Text('New File'), onTap: () {}),
///     CommandItem(title: Text('Open File'), onTap: () {}),
///     CommandItem(title: Text('Save'), onTap: () {}),
///   ],
/// )
/// ```
class CommandCategory extends StatelessWidget {
  /// The list of command items in this category.
  final List<Widget> children;
  /// Optional title widget displayed above the category items.
  final Widget? title;
  /// Creates a [CommandCategory] to group related command items.
  ///
  /// Parameters:
  /// - [children] (`List<Widget>`, required): The command items in this category
  /// - [title] (Widget?, optional): Optional category header text
  ///
  /// Example:
  /// ```dart
  /// CommandCategory(
  ///   title: Text('Edit'),
  ///   children: [
  ///     CommandItem(title: Text('Cut'), onTap: () => cut()),
  ///     CommandItem(title: Text('Copy'), onTap: () => copy()),
  ///   ],
  /// )
  /// ```
  const CommandCategory({super.key, required this.children, this.title});
  Widget build(BuildContext context);
}
```
