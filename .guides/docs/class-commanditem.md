---
title: "Class: CommandItem"
description: "Reference for CommandItem"
---

```dart
class CommandItem extends StatefulWidget {
  final Widget? leading;
  final Widget title;
  final Widget? trailing;
  final VoidCallback? onTap;
  const CommandItem({super.key, this.leading, required this.title, this.trailing, this.onTap});
  State<CommandItem> createState();
}
```
