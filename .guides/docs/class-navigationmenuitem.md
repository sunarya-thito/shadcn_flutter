---
title: "Class: NavigationMenuItem"
description: "An individual menu item within a [NavigationMenu]."
---

```dart
/// An individual menu item within a [NavigationMenu].
///
/// Represents a single interactive element in a navigation menu structure.
/// Each item can function as either a standalone action button or a trigger
/// for displaying additional content in a popover. When content is provided,
/// the item shows a chevron indicator and triggers the popover on interaction.
///
/// The item automatically integrates with its parent [NavigationMenu] to
/// manage popover state, hover interactions, and visual feedback. Items
/// with content become active when hovered or clicked, displaying their
/// associated content in the navigation menu's popover.
///
/// Example:
/// ```dart
/// NavigationMenuItem(
///   onPressed: () => print('Item pressed'),
///   content: NavigationMenuContent(
///     title: Text('Products'),
///     content: Text('Browse our product catalog'),
///   ),
///   child: Text('Products'),
/// )
/// ```
class NavigationMenuItem extends StatefulWidget {
  /// Callback invoked when this menu item is pressed.
  ///
  /// Called when the user taps or clicks on the menu item. This action
  /// is independent of content display - items with content can still
  /// have onPressed callbacks for additional behavior like navigation.
  final VoidCallback? onPressed;
  /// The content to display in the navigation menu popover.
  ///
  /// When provided, this widget is rendered in the navigation menu's
  /// popover when the item is activated. The item shows a chevron
  /// indicator and responds to hover/click interactions to display
  /// this content. If null, the item functions as a simple action button.
  final Widget? content;
  /// The main visual content of the menu item.
  ///
  /// This widget is always displayed as the item's label or trigger.
  /// It should clearly represent the item's purpose or destination
  /// and is typically a [Text] widget or icon combination.
  final Widget child;
  /// Creates a [NavigationMenuItem] with the specified properties.
  ///
  /// The [child] parameter is required as it provides the visible
  /// content for the menu item. Either [onPressed] or [content]
  /// should be provided to make the item interactive.
  ///
  /// Parameters:
  /// - [onPressed] (VoidCallback?, optional): Action when item is pressed
  /// - [content] (Widget?, optional): Content for navigation popover
  /// - [child] (Widget, required): The visible menu item content
  ///
  /// Example:
  /// ```dart
  /// NavigationMenuItem(
  ///   onPressed: _handleNavigation,
  ///   child: Row(
  ///     children: [Icon(Icons.home), Text('Home')],
  ///   ),
  /// )
  /// ```
  const NavigationMenuItem({super.key, this.onPressed, this.content, required this.child});
  State<NavigationMenuItem> createState();
}
```
