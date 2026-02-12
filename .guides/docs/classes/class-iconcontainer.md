---
title: "Class: IconContainer"
description: "A container widget for displaying an icon with customizable padding, background, and border radius.   Use [IconContainer] to wrap an icon and apply theme or custom styling.   Example:  ```dart  IconContainer(    icon: Icon(Icons.star),    backgroundColor: Colors.yellow,    borderRadius: BorderRadius.circular(8),  )  ```"
---

```dart
/// A container widget for displaying an icon with customizable padding, background, and border radius.
///
/// Use [IconContainer] to wrap an icon and apply theme or custom styling.
///
/// Example:
/// ```dart
/// IconContainer(
///   icon: Icon(Icons.star),
///   backgroundColor: Colors.yellow,
///   borderRadius: BorderRadius.circular(8),
/// )
/// ```
class IconContainer extends StatelessWidget {
  /// The icon widget to display.
  final Widget icon;
  /// Padding inside the container.
  final EdgeInsetsGeometry? padding;
  /// Border radius for the container.
  final BorderRadius? borderRadius;
  /// Background color for the container.
  final Color? backgroundColor;
  /// Color for the icon.
  final Color? iconColor;
  /// Creates an [IconContainer].
  ///
  /// Parameters:
  /// - [icon] (`Widget`, required): Icon widget to display.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): Container padding.
  /// - [borderRadius] (`BorderRadius?`, optional): Container border radius.
  /// - [backgroundColor] (`Color?`, optional): Container background color.
  /// - [iconColor] (`Color?`, optional): Icon color.
  const IconContainer({super.key, required this.icon, this.padding, this.borderRadius, this.backgroundColor, this.iconColor});
  Widget build(BuildContext context);
}
```
