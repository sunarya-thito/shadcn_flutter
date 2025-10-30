---
title: "Class: NavigationPadding"
description: "Internal widget that applies spacing between navigation items."
---

```dart
/// Internal widget that applies spacing between navigation items.
///
/// Automatically calculates and applies appropriate padding based on
/// navigation direction, item position, and parent spacing configuration.
/// Used internally by navigation components.
class NavigationPadding extends StatelessWidget {
  /// Child widget to wrap with padding.
  final Widget child;
  /// Creates a navigation padding wrapper.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Widget to wrap
  const NavigationPadding({super.key, required this.child});
  Widget build(BuildContext context);
}
```
