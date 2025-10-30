---
title: "Class: TabItem"
description: "A basic tab item widget."
---

```dart
/// A basic tab item widget.
///
/// Represents a single tab item with content that can be displayed
/// in a [TabContainer].
class TabItem extends StatelessWidget with TabChild {
  /// Content widget for this tab.
  final Widget child;
  /// Creates a [TabItem].
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): content to display in this tab
  const TabItem({super.key, required this.child});
  bool get indexed;
  Widget build(BuildContext context);
}
```
