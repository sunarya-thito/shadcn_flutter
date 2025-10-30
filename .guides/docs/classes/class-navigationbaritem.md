---
title: "Class: NavigationBarItem"
description: "Base class for navigation bar items."
---

```dart
/// Base class for navigation bar items.
///
/// Abstract widget class that all navigation items must extend.
/// Provides common interface for items within [NavigationBar].
abstract class NavigationBarItem extends Widget {
  /// Creates a [NavigationBarItem].
  const NavigationBarItem({super.key});
  /// Whether this item can be selected.
  bool get selectable;
}
```
