---
title: "Class: IconContainerTheme"
description: "Provides themed icon container widgets for shadcn_flutter components.   Includes [IconContainerTheme] and [IconContainer] for styling icons with background, padding, and border radius."
---

```dart
/// Provides themed icon container widgets for shadcn_flutter components.
///
/// Includes [IconContainerTheme] and [IconContainer] for styling icons with background, padding, and border radius.
class IconContainerTheme extends ComponentThemeData {
  /// Background color for the icon container.
  final Color? backgroundColor;
  /// Color for the icon inside the container.
  final Color? iconColor;
  /// Padding inside the icon container.
  final EdgeInsetsGeometry? padding;
  /// Border radius for the icon container.
  final BorderRadius? borderRadius;
  /// Creates an [IconContainerTheme].
  ///
  /// Parameters:
  /// - [backgroundColor] (`Color?`, optional): Container background color.
  /// - [iconColor] (`Color?`, optional): Icon color.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): Container padding.
  /// - [borderRadius] (`BorderRadius?`, optional): Container border radius.
  /// Creates an [IconContainerTheme].
  ///
  /// Parameters:
  /// - [backgroundColor] (`Color?`, optional): Container background color.
  /// - [iconColor] (`Color?`, optional): Icon color.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): Container padding.
  /// - [borderRadius] (`BorderRadius?`, optional): Container border radius.
  const IconContainerTheme({this.backgroundColor, this.iconColor, this.padding, this.borderRadius});
  /// Returns a copy of this theme with the given fields replaced.
  IconContainerTheme copyWith({ValueGetter<Color?>? backgroundColor, ValueGetter<Color?>? iconColor, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<BorderRadius?>? borderRadius});
  bool operator ==(Object other);
  int get hashCode;
}
```
