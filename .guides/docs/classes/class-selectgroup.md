---
title: "Class: SelectGroup"
description: "A container for grouping related select items with optional headers and footers."
---

```dart
/// A container for grouping related select items with optional headers and footers.
///
/// Organizes select menu items into logical sections with optional header
/// and footer widgets.
class SelectGroup extends StatelessWidget {
  /// Optional header widgets displayed above the group.
  final List<Widget>? headers;
  /// The list of select items in this group.
  final List<Widget> children;
  /// Optional footer widgets displayed below the group.
  final List<Widget>? footers;
  /// Creates a select group.
  const SelectGroup({super.key, this.headers, this.footers, required this.children});
  Widget build(BuildContext context);
}
```
