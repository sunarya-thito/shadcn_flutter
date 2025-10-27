---
title: "Class: CollapsibleContent"
description: "A content widget that shows or hides based on the parent [Collapsible] state."
---

```dart
/// A content widget that shows or hides based on the parent [Collapsible] state.
///
/// [CollapsibleContent] automatically manages its visibility based on the
/// expansion state of its parent [Collapsible]. It uses [Offstage] to
/// completely remove the content from the layout when collapsed, providing
/// efficient performance.
///
/// ## Key Features
/// - **Automatic Visibility**: Shows/hides based on parent expansion state
/// - **Layout Efficiency**: Uses [Offstage] for true layout removal when collapsed
/// - **Optional Control**: Can be configured to ignore collapsible state
/// - **Flexible Content**: Supports any widget as child content
///
/// Example:
/// ```dart
/// CollapsibleContent(
///   child: Container(
///     padding: EdgeInsets.all(16),
///     decoration: BoxDecoration(
///       border: Border.all(color: Colors.grey.shade300),
///       borderRadius: BorderRadius.circular(8),
///     ),
///     child: Column(
///       crossAxisAlignment: CrossAxisAlignment.start,
///       children: [
///         Text('Additional Details'),
///         SizedBox(height: 8),
///         Text('This content is only visible when expanded.'),
///       ],
///     ),
///   ),
/// );
/// ```
class CollapsibleContent extends StatelessWidget {
  /// Whether this content should respond to the collapsible state.
  ///
  /// When true (default), the content shows/hides based on the parent
  /// [Collapsible] expansion state. When false, the content is always visible
  /// regardless of the collapsible state.
  final bool collapsible;
  /// The widget to show or hide based on expansion state.
  ///
  /// This can be any widget content including text, images, forms, or complex
  /// layouts. The child is completely removed from the layout when collapsed.
  final Widget child;
  /// Creates a [CollapsibleContent] with the specified child widget.
  ///
  /// Parameters:
  /// - [collapsible] (bool, default: true): Whether to respond to collapsible state.
  /// - [child] (Widget, required): The content widget to show/hide.
  ///
  /// ## Behavior
  /// - When [collapsible] is true and parent is collapsed: Content is hidden via [Offstage]
  /// - When [collapsible] is true and parent is expanded: Content is visible
  /// - When [collapsible] is false: Content is always visible regardless of parent state
  ///
  /// Example:
  /// ```dart
  /// CollapsibleContent(
  ///   collapsible: true,
  ///   child: Padding(
  ///     padding: EdgeInsets.symmetric(vertical: 16),
  ///     child: Text('This content can be collapsed'),
  ///   ),
  /// );
  /// ```
  const CollapsibleContent({super.key, this.collapsible = true, required this.child});
  Widget build(BuildContext context);
}
```
