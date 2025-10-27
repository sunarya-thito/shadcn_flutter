---
title: "Class: MenubarTheme"
description: "Theme configuration for [Menubar] appearance and layout."
---

```dart
/// Theme configuration for [Menubar] appearance and layout.
///
/// MenubarTheme defines the visual styling for menubar components including
/// borders, colors, positioning, and spacing. All properties are optional
/// and fall back to theme defaults when not specified.
///
/// The theme controls both the menubar container appearance and the behavior
/// of submenu positioning when menu items are opened.
///
/// Example:
/// ```dart
/// ComponentTheme<MenubarTheme>(
///   data: MenubarTheme(
///     border: true,
///     backgroundColor: Colors.white,
///     borderColor: Colors.grey,
///     borderRadius: BorderRadius.circular(8),
///     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
///     subMenuOffset: Offset(0, 8),
///   ),
///   child: Menubar(...),
/// )
/// ```
/// Theme for [Menubar].
class MenubarTheme {
  /// Whether to draw a border around the menubar container.
  ///
  /// Type: `bool?`. If null, uses the widget's border property. When true,
  /// the menubar is wrapped with an outlined container with customizable
  /// border color and radius.
  final bool? border;
  /// Positioning offset for submenu popovers when menu items are opened.
  ///
  /// Type: `Offset?`. If null, uses calculated defaults based on border
  /// presence. Controls where submenus appear relative to their parent items.
  final Offset? subMenuOffset;
  /// Internal padding within the menubar container.
  ///
  /// Type: `EdgeInsetsGeometry?`. If null, uses 4 logical pixels on all sides
  /// scaled by theme scaling. Applied inside the border when present.
  final EdgeInsetsGeometry? padding;
  /// Color of the border when [border] is enabled.
  ///
  /// Type: `Color?`. If null, uses the theme's border color. Only visible
  /// when [border] is true.
  final Color? borderColor;
  /// Background color of the menubar container.
  ///
  /// Type: `Color?`. If null, uses the theme's background color. Applied
  /// to the menubar's container element.
  final Color? backgroundColor;
  /// Border radius for the menubar container corners.
  ///
  /// Type: `BorderRadiusGeometry?`. If null, uses the theme's medium border
  /// radius. Only visible when [border] is true.
  final BorderRadiusGeometry? borderRadius;
  /// Creates a [MenubarTheme].
  const MenubarTheme({this.border, this.subMenuOffset, this.padding, this.borderColor, this.backgroundColor, this.borderRadius});
  /// Returns a copy of this theme with the given fields replaced.
  MenubarTheme copyWith({ValueGetter<bool?>? border, ValueGetter<Offset?>? subMenuOffset, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<Color?>? borderColor, ValueGetter<Color?>? backgroundColor, ValueGetter<BorderRadiusGeometry?>? borderRadius});
  bool operator ==(Object other);
  int get hashCode;
}
```
