---
title: "Class: NavigationMenu"
description: "A horizontal navigation menu with dropdown content support."
---

```dart
/// A horizontal navigation menu with dropdown content support.
///
/// Provides a sophisticated navigation component that displays menu items
/// in a horizontal layout with support for dropdown content. When menu items
/// have associated content, hovering or clicking reveals a popover with
/// additional navigation options or information.
///
/// The navigation menu manages popover state, hover interactions, and smooth
/// transitions between different content sections. It supports both simple
/// action items and complex content-rich dropdown menus with animated
/// transitions and responsive behavior.
///
/// The menu uses a popover overlay to display content, which automatically
/// positions itself relative to the trigger and handles edge cases for
/// viewport constraints and user interactions.
///
/// Example:
/// ```dart
/// NavigationMenu(
///   surfaceOpacity: 0.95,
///   surfaceBlur: 8.0,
///   children: [
///     NavigationMenuItem(
///       child: Text('Products'),
///       content: NavigationMenuContentList(
///         children: [
///           NavigationMenuContent(title: Text('Web Apps')),
///           NavigationMenuContent(title: Text('Mobile Apps')),
///         ],
///       ),
///     ),
///     NavigationMenuItem(
///       child: Text('About'),
///       onPressed: () => Navigator.pushNamed(context, '/about'),
///     ),
///   ],
/// )
/// ```
class NavigationMenu extends StatefulWidget {
  /// Opacity level for the popover surface background.
  ///
  /// Controls the transparency of the dropdown content's background.
  /// Values range from 0.0 (fully transparent) to 1.0 (fully opaque).
  /// If not specified, uses the theme's default surface opacity.
  final double? surfaceOpacity;
  /// Blur effect intensity for the popover surface.
  ///
  /// Controls the backdrop blur effect applied behind the dropdown content.
  /// Higher values create more blur. If not specified, uses the theme's
  /// default surface blur setting.
  final double? surfaceBlur;
  /// The list of menu items to display in the navigation menu.
  ///
  /// Each item should be a [NavigationMenuItem] that defines the
  /// menu's structure and behavior. Items can have content for
  /// dropdown functionality or simple press actions.
  final List<Widget> children;
  /// Creates a [NavigationMenu] with the specified items and appearance.
  ///
  /// The [children] parameter is required and should contain
  /// [NavigationMenuItem] widgets that define the menu structure.
  /// Appearance properties are optional and will use theme defaults.
  ///
  /// Parameters:
  /// - [surfaceOpacity] (double?, optional): Popover background opacity
  /// - [surfaceBlur] (double?, optional): Popover backdrop blur intensity
  /// - [children] (`List<Widget>`, required): Menu items to display
  ///
  /// Example:
  /// ```dart
  /// NavigationMenu(
  ///   surfaceOpacity: 0.9,
  ///   children: [
  ///     NavigationMenuItem(child: Text('Home'), onPressed: _goHome),
  ///     NavigationMenuItem(child: Text('About'), onPressed: _showAbout),
  ///   ],
  /// )
  /// ```
  const NavigationMenu({super.key, this.surfaceOpacity, this.surfaceBlur, required this.children});
  State<NavigationMenu> createState();
}
```
