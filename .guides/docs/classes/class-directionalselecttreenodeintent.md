---
title: "Class: DirectionalSelectTreeNodeIntent"
description: "Intent to navigate and select tree nodes directionally."
---

```dart
/// Intent to navigate and select tree nodes directionally.
///
/// Used with Flutter's Actions/Shortcuts system to move focus
/// up or down the tree and optionally select nodes.
class DirectionalSelectTreeNodeIntent extends Intent {
  /// Whether to move forward (true) or backward (false) in the tree.
  final bool forward;
  /// Creates a [DirectionalSelectTreeNodeIntent].
  const DirectionalSelectTreeNodeIntent(this.forward);
}
```
