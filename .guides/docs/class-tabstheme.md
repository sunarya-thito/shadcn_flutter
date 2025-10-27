---
title: "Class: TabsTheme"
description: "Theme data for customizing [Tabs] widget appearance."
---

```dart
/// Theme data for customizing [Tabs] widget appearance.
///
/// This class defines the visual properties that can be applied to
/// [Tabs] widgets, including padding for the container and individual tabs,
/// background colors, and border radius styling. These properties can be
/// set at the theme level to provide consistent styling across the application.
class TabsTheme {
  final EdgeInsetsGeometry? containerPadding;
  final EdgeInsetsGeometry? tabPadding;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  const TabsTheme({this.containerPadding, this.tabPadding, this.backgroundColor, this.borderRadius});
  TabsTheme copyWith({ValueGetter<EdgeInsetsGeometry?>? containerPadding, ValueGetter<EdgeInsetsGeometry?>? tabPadding, ValueGetter<Color?>? backgroundColor, ValueGetter<BorderRadiusGeometry?>? borderRadius});
  bool operator ==(Object other);
  int get hashCode;
}
```
