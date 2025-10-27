---
title: "Class: NavigationMenuTheme"
description: "Theme configuration for [NavigationMenu] components."
---

```dart
/// Theme configuration for [NavigationMenu] components.
///
/// Defines visual properties for navigation menu popovers including
/// surface appearance, positioning, and spacing. This theme controls
/// how navigation menu content is displayed when triggered.
///
/// The theme can be applied through [ComponentTheme] or passed directly
/// to individual [NavigationMenu] widgets for customization.
class NavigationMenuTheme {
  /// Opacity of the popover surface.
  final double? surfaceOpacity;
  /// Blur amount of the popover surface.
  final double? surfaceBlur;
  /// Margin applied to the popover.
  final EdgeInsetsGeometry? margin;
  /// Offset for the popover relative to the trigger.
  final Offset? offset;
  /// Creates a [NavigationMenuTheme] with the specified appearance properties.
  ///
  /// All parameters are optional and will fall back to default values
  /// when not provided. This allows for partial customization while
  /// maintaining consistent defaults.
  ///
  /// Parameters:
  /// - [surfaceOpacity] (double?, optional): Opacity level for popover background
  /// - [surfaceBlur] (double?, optional): Blur effect intensity for popover
  /// - [margin] (EdgeInsetsGeometry?, optional): Space around the popover
  /// - [offset] (Offset?, optional): Position offset relative to trigger
  ///
  /// Example:
  /// ```dart
  /// NavigationMenuTheme(
  ///   surfaceOpacity: 0.9,
  ///   surfaceBlur: 8.0,
  ///   margin: EdgeInsets.all(16.0),
  ///   offset: Offset(0, 8),
  /// )
  /// ```
  const NavigationMenuTheme({this.surfaceOpacity, this.surfaceBlur, this.margin, this.offset});
  /// Returns a copy of this theme with the given fields replaced.
  NavigationMenuTheme copyWith({ValueGetter<double?>? surfaceOpacity, ValueGetter<double?>? surfaceBlur, ValueGetter<EdgeInsetsGeometry?>? margin, ValueGetter<Offset?>? offset});
  bool operator ==(Object other);
  int get hashCode;
}
```
