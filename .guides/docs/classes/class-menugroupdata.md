---
title: "Class: MenuGroupData"
description: "Reference for MenuGroupData"
---

```dart
class MenuGroupData {
  final MenuGroupData? parent;
  final List<MenuData> children;
  final bool hasLeading;
  final Offset? subMenuOffset;
  final VoidCallback? onDismissed;
  final Object? regionGroupId;
  final Axis direction;
  final EdgeInsets itemPadding;
  final SubFocusScopeState focusScope;
  MenuGroupData(this.parent, this.children, this.hasLeading, this.subMenuOffset, this.onDismissed, this.regionGroupId, this.direction, this.itemPadding, this.focusScope);
  bool get hasOpenPopovers;
  void closeOthers();
  void closeAll();
  bool operator ==(Object other);
  MenuGroupData get root;
  int get hashCode;
  String toString();
}
```
