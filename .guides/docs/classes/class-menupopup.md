---
title: "Class: MenuPopup"
description: "A styled container widget for displaying popup menus."
---

```dart
/// A styled container widget for displaying popup menus.
///
/// Provides a consistent visual container for menu items with customizable
/// appearance including background, borders, padding, and surface effects.
/// Automatically adapts its layout based on context (sheet overlay, dialog, etc.).
///
/// Features:
/// - **Surface Effects**: Configurable opacity and blur for backdrop
/// - **Styled Border**: Custom border color and radius
/// - **Flexible Layout**: Automatically adjusts for vertical/horizontal menus
/// - **Scrollable**: Content scrolls when it exceeds available space
/// - **Themeable**: Integrates with component theming system
///
/// Typically used as a container for menu items within dropdown menus,
/// context menus, or other popup menu components.
///
/// Example:
/// ```dart
/// MenuPopup(
///   padding: EdgeInsets.all(8),
///   fillColor: Colors.white,
///   borderRadius: BorderRadius.circular(8),
///   children: [
///     MenuItem(title: Text('Option 1')),
///     MenuItem(title: Text('Option 2')),
///     MenuItem(title: Text('Option 3')),
///   ],
/// )
/// ```
///
/// See also:
/// - [MenuPopupTheme] for theming options
/// - [MenuItem] for individual menu items
/// - [DropdownMenu] for complete dropdown menu implementation
class MenuPopup extends StatelessWidget {
  /// Opacity of the surface blur effect.
  ///
  /// Controls the transparency of the backdrop blur. Higher values make
  /// the blur more visible. If `null`, uses theme default.
  final double? surfaceOpacity;
  /// Amount of blur to apply to the surface behind the popup.
  ///
  /// Higher values create more blur effect. If `null`, uses theme default.
  final double? surfaceBlur;
  /// Internal padding around the menu items.
  ///
  /// Defines the space between the popup's border and its content.
  /// If `null`, uses theme default or adaptive default based on overlay type.
  final EdgeInsetsGeometry? padding;
  /// Background fill color of the popup.
  ///
  /// If `null`, uses the theme's popover color.
  final Color? fillColor;
  /// Border color of the popup.
  ///
  /// If `null`, uses the theme's border color.
  final Color? borderColor;
  /// Corner radius of the popup border.
  ///
  /// If `null`, uses the theme's medium border radius.
  final BorderRadiusGeometry? borderRadius;
  /// The menu items to display inside the popup.
  ///
  /// Typically a list of [MenuItem] widgets or similar menu components.
  final List<Widget> children;
  /// Creates a menu popup container.
  ///
  /// Parameters:
  /// - [children]: Menu items to display (required)
  /// - [surfaceOpacity]: Backdrop blur opacity
  /// - [surfaceBlur]: Amount of surface blur
  /// - [padding]: Internal padding
  /// - [fillColor]: Background color
  /// - [borderColor]: Border color
  /// - [borderRadius]: Corner radius
  const MenuPopup({super.key, this.surfaceOpacity, this.surfaceBlur, this.padding, this.fillColor, this.borderColor, this.borderRadius, required this.children});
  Widget build(BuildContext context);
}
```
