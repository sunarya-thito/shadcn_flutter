---
title: "Class: Accordion"
description: "A container widget that displays a list of collapsible items with only one item expanded at a time."
---

```dart
/// A container widget that displays a list of collapsible items with only one item expanded at a time.
///
/// [Accordion] implements the classic accordion UI pattern where clicking on one item
/// expands it while automatically collapsing any other expanded items. This ensures
/// only one section is visible at a time, making it ideal for organizing related
/// information in a compact, scannable format.
///
/// ## Key Features
/// - **Single Expansion**: Only one accordion item can be expanded at a time
/// - **Visual Separation**: Automatic dividers between accordion items
/// - **Smooth Animation**: Configurable expand/collapse animations
/// - **Accessibility**: Full keyboard navigation and screen reader support
/// - **Theming**: Comprehensive theming via [AccordionTheme]
///
/// ## Usage Pattern
/// An accordion consists of multiple [AccordionItem] widgets, each containing:
/// - [AccordionTrigger]: The clickable header that shows/hides content
/// - Content: The collapsible content area revealed when expanded
///
/// The accordion automatically manages state to ensure mutual exclusion of expanded items.
///
/// Example:
/// ```dart
/// Accordion(
///   items: [
///     AccordionItem(
///       trigger: AccordionTrigger(
///         child: Text('Section 1'),
///       ),
///       content: Text('Content for section 1...'),
///     ),
///     AccordionItem(
///       trigger: AccordionTrigger(
///         child: Text('Section 2'),
///       ),
///       content: Text('Content for section 2...'),
///       expanded: true, // Initially expanded
///     ),
///   ],
/// );
/// ```
class Accordion extends StatefulWidget {
  /// The list of accordion items to display.
  ///
  /// Each item should be an [AccordionItem] widget containing a trigger and content.
  /// The accordion automatically adds visual dividers between items and manages
  /// the expansion state to ensure only one item can be expanded at a time.
  final List<Widget> items;
  /// Creates an [Accordion] widget with the specified items.
  ///
  /// Parameters:
  /// - [items] (`List<Widget>`, required): List of [AccordionItem] widgets to display.
  ///
  /// The accordion automatically handles:
  /// - State management for mutual exclusion of expanded items
  /// - Visual dividers between items
  /// - Animation coordination between items
  /// - Proper accessibility semantics
  ///
  /// Example:
  /// ```dart
  /// Accordion(
  ///   items: [
  ///     AccordionItem(
  ///       trigger: AccordionTrigger(child: Text('FAQ 1')),
  ///       content: Text('Answer to first question...'),
  ///     ),
  ///     AccordionItem(
  ///       trigger: AccordionTrigger(child: Text('FAQ 2')),
  ///       content: Text('Answer to second question...'),
  ///     ),
  ///   ],
  /// );
  /// ```
  const Accordion({super.key, required this.items});
  AccordionState createState();
}
```
