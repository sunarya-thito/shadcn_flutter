---
title: "Mixin: NavigationContainerMixin"
description: "A mixin for navigation containers that provides child wrapping functionality."
---

```dart
/// A mixin for navigation containers that provides child wrapping functionality.
///
/// This mixin is used to enhance navigation containers with the ability to wrap
/// navigation items with necessary control data. It tracks item positions and
/// manages selectable state for proper navigation behavior.
mixin NavigationContainerMixin {
  /// Wraps navigation bar items with control data for selection tracking.
  ///
  /// Takes a list of [NavigationBarItem] children and wraps each with
  /// [NavigationChildControlData] that tracks the item's index and selection state.
  /// Only selectable items receive a selection index, while non-selectable items
  /// have a null selection index.
  ///
  /// Parameters:
  /// - [context] (`BuildContext`, required): Build context for inherited data.
  /// - [children] (`List<NavigationBarItem>`, required): Navigation items to wrap.
  ///
  /// Returns: `List<Widget>` — wrapped navigation items with control data.
  ///
  /// Example:
  /// ```dart
  /// final wrappedItems = wrapChildren(
  ///   context,
  ///   [
  ///     NavigationBarItem(icon: Icon(Icons.home), selectable: true),
  ///     NavigationBarItem(icon: Icon(Icons.settings), selectable: true),
  ///   ],
  /// );
  /// ```
  List<Widget> wrapChildren(BuildContext context, List<NavigationBarItem> children);
}
```
