---
title: "Class: Divider"
description: "A horizontal line widget used to visually separate content sections."
---

```dart
/// A horizontal line widget used to visually separate content sections.
///
/// [Divider] creates a thin horizontal line that spans the available width,
/// optionally with indentation from either end. It's commonly used to separate
/// content sections, list items, or create visual breaks in layouts. The divider
/// can optionally contain a child widget (such as text) that appears centered
/// on the divider line.
///
/// Key features:
/// - Horizontal line spanning available width
/// - Configurable thickness and color
/// - Optional indentation from start and end
/// - Support for child widgets (text, icons, etc.)
/// - Customizable padding around child content
/// - Theme integration for consistent styling
/// - Implements PreferredSizeWidget for flexible layout
///
/// The divider automatically adapts to the current theme's border color
/// and can be customized through individual properties or theme configuration.
/// When a child is provided, the divider line is broken to accommodate the
/// child content with appropriate padding.
///
/// Common use cases:
/// - Separating sections in forms or settings screens
/// - Creating breaks between list items
/// - Dividing content areas in complex layouts
/// - Adding labeled dividers with text or icons
///
/// Example:
/// ```dart
/// Column(
///   children: [
///     Text('Section 1'),
///     Divider(),
///     Text('Section 2'),
///     Divider(
///       child: Text('OR', style: TextStyle(color: Colors.grey)),
///       thickness: 2,
///       indent: 20,
///       endIndent: 20,
///     ),
///     Text('Section 3'),
///   ],
/// );
/// ```
class Divider extends StatelessWidget implements PreferredSizeWidget {
  /// The color of the divider line.
  final Color? color;
  /// The total height of the divider (including padding).
  final double? height;
  /// The thickness of the divider line.
  final double? thickness;
  /// The amount of empty space before the divider line starts.
  final double? indent;
  /// The amount of empty space after the divider line ends.
  final double? endIndent;
  /// Optional child widget to display alongside the divider (e.g., text label).
  final Widget? child;
  /// Padding around the divider content.
  final EdgeInsetsGeometry? padding;
  /// Creates a horizontal divider.
  const Divider({super.key, this.color, this.height, this.thickness, this.indent, this.endIndent, this.child, this.padding});
  Size get preferredSize;
  Widget build(BuildContext context);
}
```
