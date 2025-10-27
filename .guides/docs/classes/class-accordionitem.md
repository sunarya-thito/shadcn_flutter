---
title: "Class: AccordionItem"
description: "An individual item within an [Accordion] that can be expanded or collapsed."
---

```dart
/// An individual item within an [Accordion] that can be expanded or collapsed.
///
/// [AccordionItem] represents a single section within an accordion, containing
/// both a trigger (the clickable header) and the collapsible content area. It
/// manages its own animation state and coordinates with the parent [Accordion]
/// to implement the mutual exclusion behavior.
///
/// ## Key Features
/// - **Smooth Animation**: Configurable size transition animations
/// - **State Coordination**: Automatic integration with parent accordion state
/// - **Flexible Content**: Supports any widget as trigger or content
/// - **Initial State**: Can start expanded or collapsed
///
/// The item automatically handles expansion/collapse animations and coordinates
/// with its parent accordion to ensure only one item can be expanded at a time.
///
/// Example:
/// ```dart
/// AccordionItem(
///   expanded: true, // Start expanded
///   trigger: AccordionTrigger(
///     child: Row(
///       children: [
///         Icon(Icons.help_outline),
///         SizedBox(width: 8),
///         Text('Frequently Asked Question'),
///       ],
///     ),
///   ),
///   content: Padding(
///     padding: EdgeInsets.all(16),
///     child: Text('This is the detailed answer to the question...'),
///   ),
/// );
/// ```
class AccordionItem extends StatefulWidget {
  /// The clickable header widget that controls expansion.
  ///
  /// Typically an [AccordionTrigger] widget, but can be any widget that
  /// provides user interaction. The trigger is always visible and clicking
  /// it toggles the expansion state of the item.
  final Widget trigger;
  /// The collapsible content widget revealed when expanded.
  ///
  /// This content is hidden when the item is collapsed and smoothly animated
  /// into view when expanded. Can contain any widget content including text,
  /// images, forms, or other complex UI elements.
  final Widget content;
  /// Whether this item should start in the expanded state.
  ///
  /// When true, the item begins expanded and its content is immediately visible.
  /// Only one item in an accordion should typically start expanded.
  final bool expanded;
  /// Creates an [AccordionItem] with the specified trigger and content.
  ///
  /// Parameters:
  /// - [trigger] (Widget, required): The clickable header widget.
  /// - [content] (Widget, required): The collapsible content widget.
  /// - [expanded] (bool, default: false): Initial expansion state.
  ///
  /// The item automatically integrates with its parent [Accordion] to provide
  /// proper state management and mutual exclusion behavior.
  ///
  /// Example:
  /// ```dart
  /// AccordionItem(
  ///   trigger: AccordionTrigger(
  ///     child: Text('Item Title'),
  ///   ),
  ///   content: Container(
  ///     padding: EdgeInsets.all(16),
  ///     child: Text('Item content goes here...'),
  ///   ),
  ///   expanded: false,
  /// );
  /// ```
  const AccordionItem({super.key, required this.trigger, required this.content, this.expanded = false});
  State<AccordionItem> createState();
}
```
