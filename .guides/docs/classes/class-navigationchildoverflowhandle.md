---
title: "Class: NavigationChildOverflowHandle"
description: "Internal widget that handles label overflow based on [NavigationOverflow]."
---

```dart
/// Internal widget that handles label overflow based on [NavigationOverflow].
class NavigationChildOverflowHandle extends StatelessWidget {
  /// How to handle overflow.
  final NavigationOverflow overflow;
  /// The content that might overflow.
  final Widget child;
  /// Creates a [NavigationChildOverflowHandle].
  const NavigationChildOverflowHandle({super.key, required this.overflow, required this.child});
  Widget build(BuildContext context);
}
```
