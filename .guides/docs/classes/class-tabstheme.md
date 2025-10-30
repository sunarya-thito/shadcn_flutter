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
  /// Padding around the entire tabs container.
  ///
  /// Defines the outer spacing for the tabs widget. If `null`,
  /// uses the theme's default container padding.
  final EdgeInsetsGeometry? containerPadding;
  /// Padding inside individual tab headers.
  ///
  /// Defines the spacing within each tab button. If `null`,
  /// uses the theme's default tab padding.
  final EdgeInsetsGeometry? tabPadding;
  /// Background color for the tabs container.
  ///
  /// Applied to the tabs bar background. If `null`,
  /// uses the theme's default background color.
  final Color? backgroundColor;
  /// Corner radius for the tabs container.
  ///
  /// Defines rounded corners for the tabs widget. If `null`,
  /// uses the theme's default border radius.
  final BorderRadiusGeometry? borderRadius;
  /// Creates a tabs theme.
  ///
  /// All parameters are optional and default to theme values when `null`.
  const TabsTheme({this.containerPadding, this.tabPadding, this.backgroundColor, this.borderRadius});
  /// Creates a copy of this theme with optionally replaced values.
  ///
  /// Uses [ValueGetter] functions to allow nullable value replacement.
  /// Properties not provided retain their current values.
  ///
  /// Parameters:
  /// - [containerPadding]: Optional getter for new container padding
  /// - [tabPadding]: Optional getter for new tab padding
  /// - [backgroundColor]: Optional getter for new background color
  /// - [borderRadius]: Optional getter for new border radius
  ///
  /// Returns a new [TabsTheme] with updated values.
  TabsTheme copyWith({ValueGetter<EdgeInsetsGeometry?>? containerPadding, ValueGetter<EdgeInsetsGeometry?>? tabPadding, ValueGetter<Color?>? backgroundColor, ValueGetter<BorderRadiusGeometry?>? borderRadius});
  bool operator ==(Object other);
  int get hashCode;
}
```
