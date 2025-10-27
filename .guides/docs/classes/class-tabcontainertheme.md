---
title: "Class: TabContainerTheme"
description: "{@template tab_container_theme}  Theme data for [TabContainer] providing default builders."
---

```dart
/// {@template tab_container_theme}
/// Theme data for [TabContainer] providing default builders.
/// {@endtemplate}
class TabContainerTheme {
  /// Default builder for laying out tab children.
  final TabBuilder? builder;
  /// Default builder for wrapping each tab child.
  final TabChildBuilder? childBuilder;
  /// {@macro tab_container_theme}
  const TabContainerTheme({this.builder, this.childBuilder});
  /// Creates a copy of this theme with the given fields replaced.
  TabContainerTheme copyWith({ValueGetter<TabBuilder?>? builder, ValueGetter<TabChildBuilder?>? childBuilder});
  int get hashCode;
  bool operator ==(Object other);
  String toString();
}
```
