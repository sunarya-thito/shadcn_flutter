---
title: "Class: NavigationMenuContent"
description: "A content item displayed within a navigation menu popover."
---

```dart
/// A content item displayed within a navigation menu popover.
///
/// Provides a structured layout for navigation menu content with support
/// for titles, descriptions, leading/trailing widgets, and interactive behavior.
/// This widget is designed to be used within [NavigationMenuItem] content
/// to create rich, informative menu options.
///
/// The content displays as a button with optional leading icon, title text,
/// descriptive content, and trailing elements. When pressed, it can trigger
/// custom actions while maintaining the navigation menu's visual consistency.
///
/// Example:
/// ```dart
/// NavigationMenuContent(
///   leading: Icon(Icons.dashboard),
///   title: Text('Dashboard'),
///   content: Text('View project analytics and metrics'),
///   onPressed: () => Navigator.pushNamed(context, '/dashboard'),
/// )
/// ```
class NavigationMenuContent extends StatelessWidget {
  /// The primary title text for this content item.
  ///
  /// Displayed prominently as the main label for this navigation option.
  /// Should clearly indicate the destination or action this item represents.
  final Widget title;
  /// Optional descriptive content shown below the title.
  ///
  /// Provides additional context or explanation for the navigation option.
  /// Rendered in a muted text style to maintain visual hierarchy.
  final Widget? content;
  /// Optional widget displayed before the title.
  ///
  /// Commonly used for icons or other visual indicators that help
  /// identify the navigation option at a glance.
  final Widget? leading;
  /// Optional widget displayed after the title and content.
  ///
  /// Can be used for badges, indicators, or additional actions
  /// related to this navigation option.
  final Widget? trailing;
  /// Callback invoked when this content item is pressed.
  ///
  /// Called when the user taps or clicks on the content item.
  /// Typically used for navigation or other actions.
  final VoidCallback? onPressed;
  /// Creates a [NavigationMenuContent] with the specified properties.
  ///
  /// The [title] parameter is required as it provides the primary
  /// label for the navigation option. All other parameters are
  /// optional and enhance the content's functionality and appearance.
  ///
  /// Parameters:
  /// - [title] (Widget, required): The primary title text
  /// - [content] (Widget?, optional): Descriptive text below title
  /// - [leading] (Widget?, optional): Icon or widget before title
  /// - [trailing] (Widget?, optional): Widget after title and content
  /// - [onPressed] (VoidCallback?, optional): Action when item is pressed
  ///
  /// Example:
  /// ```dart
  /// NavigationMenuContent(
  ///   leading: Icon(Icons.settings),
  ///   title: Text('Settings'),
  ///   content: Text('Manage application preferences'),
  ///   trailing: Icon(Icons.arrow_forward_ios, size: 16),
  ///   onPressed: _openSettings,
  /// )
  /// ```
  const NavigationMenuContent({super.key, required this.title, this.content, this.leading, this.trailing, this.onPressed});
  Widget build(BuildContext context);
}
```
