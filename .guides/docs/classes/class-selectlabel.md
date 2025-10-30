---
title: "Class: SelectLabel"
description: "A label widget for grouping items in a select popup."
---

```dart
/// A label widget for grouping items in a select popup.
///
/// Displays a non-selectable label to organize dropdown items into categories.
///
/// Example:
/// ```dart
/// SelectLabel(
///   child: Text('Category Name'),
/// )
/// ```
class SelectLabel extends StatelessWidget {
  /// The label content.
  final Widget child;
  /// Creates a [SelectLabel].
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): Label content.
  const SelectLabel({super.key, required this.child});
  Widget build(BuildContext context);
}
```
