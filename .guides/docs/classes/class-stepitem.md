---
title: "Class: StepItem"
description: "A vertical step indicator widget that displays a step's title and content."
---

```dart
/// A vertical step indicator widget that displays a step's title and content.
///
/// Typically used as children within [Steps] to create a multi-step
/// process visualization. Displays a title in bold followed by content items.
///
/// Example:
/// ```dart
/// StepItem(
///   title: Text('Step Title'),
///   content: [
///     Text('Step description'),
///     Text('Additional details'),
///   ],
/// )
/// ```
class StepItem extends StatelessWidget {
  /// The title of this step, displayed prominently.
  final Widget title;
  /// List of content widgets to display under the title.
  final List<Widget> content;
  /// Creates a [StepItem].
  const StepItem({super.key, required this.title, required this.content});
  Widget build(BuildContext context);
}
```
