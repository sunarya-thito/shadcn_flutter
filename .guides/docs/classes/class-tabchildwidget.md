---
title: "Class: TabChildWidget"
description: "A simple tab child widget wrapping arbitrary content."
---

```dart
/// A simple tab child widget wrapping arbitrary content.
///
/// Implements [TabChild] to make any widget usable within a tab container.
/// The wrapped child is rendered directly without additional decoration.
class TabChildWidget extends StatelessWidget with TabChild {
  /// The child widget to display.
  final Widget child;
  /// Whether this tab uses indexed positioning.
  ///
  /// Defaults to `false` unless specified in the constructor.
  final bool indexed;
  /// Creates a tab child widget.
  ///
  /// Parameters:
  /// - [child]: The widget to wrap (required)
  /// - [indexed]: Whether to use indexed positioning (defaults to `false`)
  const TabChildWidget({super.key, required this.child, this.indexed = false});
  Widget build(BuildContext context);
}
```
