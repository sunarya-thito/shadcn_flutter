---
title: "Class: AccordionTrigger"
description: "A specialized trigger widget designed for use within [AccordionItem]."
---

```dart
/// A specialized trigger widget designed for use within [AccordionItem].
///
/// [AccordionTrigger] provides a consistent, accessible interface for accordion
/// headers. It automatically includes:
/// - Hover effects with text underlining
/// - Focus management with keyboard navigation
/// - Animated expand/collapse icon
/// - Proper click and keyboard activation
/// - Accessibility semantics
///
/// The trigger automatically coordinates with its parent [AccordionItem] to
/// control the expansion state and provides visual feedback for user interactions.
///
/// ## Accessibility Features
/// - Full keyboard navigation support (Enter and Space keys)
/// - Focus indicators with theme-appropriate styling
/// - Screen reader compatibility
/// - Proper semantic roles and states
///
/// Example:
/// ```dart
/// AccordionTrigger(
///   child: Row(
///     children: [
///       Icon(Icons.info_outline),
///       SizedBox(width: 12),
///       Expanded(
///         child: Column(
///           crossAxisAlignment: CrossAxisAlignment.start,
///           children: [
///             Text('Primary Title', style: TextStyle(fontWeight: FontWeight.bold)),
///             Text('Subtitle', style: TextStyle(fontSize: 12)),
///           ],
///         ),
///       ),
///     ],
///   ),
/// );
/// ```
class AccordionTrigger extends StatefulWidget {
  /// The content widget displayed within the trigger.
  ///
  /// Typically contains text, icons, or other UI elements that describe the
  /// accordion section. The child receives automatic text styling and hover
  /// effects from the trigger.
  final Widget child;
  /// Creates an [AccordionTrigger] with the specified child content.
  ///
  /// Parameters:
  /// - [child] (Widget, required): The content to display in the trigger.
  ///
  /// The trigger automatically provides:
  /// - Click and keyboard interaction handling
  /// - Hover effects with text underlining
  /// - Focus management with visual indicators
  /// - Animated expand/collapse icon
  /// - Integration with parent [AccordionItem] state
  ///
  /// Example:
  /// ```dart
  /// AccordionTrigger(
  ///   child: Text('Click to expand this section'),
  /// );
  /// ```
  const AccordionTrigger({super.key, required this.child});
  State<AccordionTrigger> createState();
}
```
