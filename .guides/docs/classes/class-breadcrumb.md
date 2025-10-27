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
  static const Widget arrowSeparator = _ArrowSeparator();
  static const Widget slashSeparator = _SlashSeparator();
  final List<Widget> children;
  final Widget? separator;
  final EdgeInsetsGeometry? padding;
  /// Creates a [Breadcrumb] navigation trail.
  ///
  /// The last child in the list is treated as the current location and
  /// is styled differently from the preceding navigation items.
  ///
  /// Parameters:
  /// - [children] (List<Widget>, required): breadcrumb items from root to current
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
