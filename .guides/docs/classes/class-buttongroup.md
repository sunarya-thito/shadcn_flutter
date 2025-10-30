---
title: "Class: ButtonGroup"
description: "A widget that groups multiple buttons together with connected borders."
---

```dart
/// A widget that groups multiple buttons together with connected borders.
///
/// [ButtonGroup] visually connects a series of related buttons by removing
/// the borders between adjacent buttons and maintaining consistent styling.
/// This creates a segmented appearance where the buttons appear as a single
/// cohesive unit.
///
/// The group can be oriented horizontally or vertically, and automatically
/// handles border radius adjustments so that only the first and last buttons
/// in the group have rounded corners on their outer edges.
///
/// Commonly used for:
/// - Toggle button groups (like text formatting options)
/// - Related action sets (like alignment controls)
/// - Pagination controls
/// - View switchers
///
/// Example:
/// ```dart
/// ButtonGroup(
///   direction: Axis.horizontal,
///   children: [
///     Button.secondary(
///       onPressed: () => align('left'),
///       child: Icon(Icons.format_align_left),
///     ),
///     Button.secondary(
///       onPressed: () => align('center'),
///       child: Icon(Icons.format_align_center),
///     ),
///     Button.secondary(
///       onPressed: () => align('right'),
///       child: Icon(Icons.format_align_right),
///     ),
///   ],
/// );
/// ```
class ButtonGroup extends StatelessWidget {
  /// The layout direction for the button group.
  ///
  /// [Axis.horizontal] arranges buttons in a row, removing vertical borders
  /// between adjacent buttons. [Axis.vertical] arranges buttons in a column,
  /// removing horizontal borders between adjacent buttons.
  final Axis direction;
  /// The list of button widgets to group together.
  ///
  /// Each widget should typically be a [Button] or similar interactive widget.
  /// The group automatically applies border modifications to create the
  /// connected appearance.
  final List<Widget> children;
  /// Whether the button group should be shrink-wrapped or expanded.
  ///
  /// When true, the group will expand to fill available space in the
  /// cross axis. When false, the group will size itself based on its
  /// children's intrinsic size.
  final bool expands;
  /// Creates a [ButtonGroup] that arranges buttons with connected borders.
  ///
  /// Parameters:
  /// - [direction] (Axis, default: Axis.horizontal): Layout direction for the buttons.
  /// - [children] (`List<Widget>`, required): The buttons to group together.
  ///
  /// The group automatically handles:
  /// - Border radius adjustments for first/middle/last buttons
  /// - Proper sizing with [IntrinsicHeight] or [IntrinsicWidth]
  /// - Stretch alignment for consistent button heights/widths
  ///
  /// Example:
  /// ```dart
  /// ButtonGroup(
  ///   direction: Axis.vertical,
  ///   children: [
  ///     Button.outline(child: Text('Option 1')),
  ///     Button.outline(child: Text('Option 2')),
  ///     Button.outline(child: Text('Option 3')),
  ///   ],
  /// );
  /// ```
  const ButtonGroup({super.key, this.direction = Axis.horizontal, this.expands = false, required this.children});
  /// Creates a horizontal button group.
  ///
  /// A convenience constructor equivalent to `ButtonGroup(direction: Axis.horizontal)`.
  /// Arranges buttons in a row with connected borders.
  const ButtonGroup.horizontal({super.key, this.expands = false, required this.children});
  /// Creates a vertical button group.
  ///
  /// A convenience constructor equivalent to `ButtonGroup(direction: Axis.vertical)`.
  /// Arranges buttons in a column with connected borders.
  const ButtonGroup.vertical({super.key, this.expands = false, required this.children});
  Widget build(BuildContext context);
}
```
