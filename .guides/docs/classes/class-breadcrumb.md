---
title: "Class: Breadcrumb"
description: "Navigation breadcrumb trail showing hierarchical path with customizable separators."
---

```dart
/// Navigation breadcrumb trail showing hierarchical path with customizable separators.
///
/// A horizontal navigation widget that displays a series of linked items
/// representing the current location within a hierarchical structure.
/// Automatically adds separators between items and supports horizontal scrolling
/// for overflow handling.
///
/// ## Features
///
/// - **Hierarchical navigation**: Clear visual representation of path structure
/// - **Customizable separators**: Built-in arrow and slash separators or custom widgets
/// - **Overflow handling**: Horizontal scrolling when content exceeds available width
/// - **Touch-optimized**: Mobile-friendly scrolling behavior
/// - **Theming support**: Consistent styling through theme system
/// - **Responsive**: Automatically adapts to different screen sizes
///
/// The breadcrumb automatically handles the last item differently, showing it
/// as the current location without making it interactive.
///
/// Example:
/// ```dart
/// Breadcrumb(
///   separator: Breadcrumb.slashSeparator,
///   children: [
///     GestureDetector(
///       onTap: () => Navigator.pop(context),
///       child: Text('Home'),
///     ),
///     GestureDetector(
///       onTap: () => Navigator.pop(context),
///       child: Text('Products'),
///     ),
///     Text('Electronics'), // Current page
///   ],
/// );
/// ```
class Breadcrumb extends StatelessWidget {
  /// Default arrow separator widget (>).
  ///
  /// Can be used as the [separator] parameter for arrow-style navigation.
  static const Widget arrowSeparator = _ArrowSeparator();
  /// Default slash separator widget (/).
  ///
  /// Can be used as the [separator] parameter for slash-style navigation.
  static const Widget slashSeparator = _SlashSeparator();
  /// The list of breadcrumb navigation items.
  ///
  /// Each widget represents a step in the navigation trail, from root to
  /// current location. The last item is styled as the current page.
  final List<Widget> children;
  /// Widget displayed between breadcrumb items.
  ///
  /// If `null`, uses the default separator from the theme.
  final Widget? separator;
  /// Padding around the entire breadcrumb widget.
  ///
  /// If `null`, uses default padding from the theme.
  final EdgeInsetsGeometry? padding;
  /// Creates a [Breadcrumb] navigation trail.
  ///
  /// The last child in the list is treated as the current location and
  /// is styled differently from the preceding navigation items.
  ///
  /// Parameters:
  /// - [children] (`List<Widget>`, required): breadcrumb items from root to current
  /// - [separator] (Widget?, optional): custom separator between items
  /// - [padding] (EdgeInsetsGeometry?, optional): padding around the breadcrumb
  ///
  /// Example:
  /// ```dart
  /// Breadcrumb(
  ///   separator: Icon(Icons.chevron_right),
  ///   children: [
  ///     TextButton(onPressed: goHome, child: Text('Home')),
  ///     TextButton(onPressed: goToCategory, child: Text('Category')),
  ///     Text('Current Page'),
  ///   ],
  /// )
  /// ```
  const Breadcrumb({super.key, required this.children, this.separator, this.padding});
  Widget build(BuildContext context);
}
```
