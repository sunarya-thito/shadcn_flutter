---
title: "Class: MenuGroup"
description: "Reference for MenuGroup"
---

```dart
class MenuGroup extends StatefulWidget {
  final List<MenuItem> children;
  final Widget Function(BuildContext context, List<Widget> children) builder;
  final MenuGroupData? parent;
  final Offset? subMenuOffset;
  final VoidCallback? onDismissed;
  final Object? regionGroupId;
  final Axis direction;
  final Map<Type, Action> actions;
  final EdgeInsets? itemPadding;
  final bool autofocus;
  final FocusNode? focusNode;
  const MenuGroup({super.key, required this.children, required this.builder, this.parent, this.subMenuOffset, this.onDismissed, this.regionGroupId, this.actions = const {}, required this.direction, this.itemPadding, this.autofocus = true, this.focusNode});
  State<MenuGroup> createState();
}
```
