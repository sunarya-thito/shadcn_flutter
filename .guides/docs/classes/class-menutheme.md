---
title: "Class: MenuTheme"
description: "{@template menu_theme}  Styling options for menu widgets such as [MenuGroup] and [MenuButton]."
---

```dart
/// {@template menu_theme}
/// Styling options for menu widgets such as [MenuGroup] and [MenuButton].
/// {@endtemplate}
class MenuTheme {
  /// Default padding applied to each menu item.
  final EdgeInsets? itemPadding;
  /// Offset applied when showing a submenu.
  final Offset? subMenuOffset;
  /// {@macro menu_theme}
  const MenuTheme({this.itemPadding, this.subMenuOffset});
  /// Creates a copy of this theme but with the given fields replaced.
  MenuTheme copyWith({ValueGetter<EdgeInsets?>? itemPadding, ValueGetter<Offset?>? subMenuOffset});
  int get hashCode;
  bool operator ==(Object other);
  String toString();
}
```
