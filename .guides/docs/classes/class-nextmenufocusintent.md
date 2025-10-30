---
title: "Class: NextMenuFocusIntent"
description: "Intent for moving focus to next/previous menu item."
---

```dart
/// Intent for moving focus to next/previous menu item.
///
/// Used for keyboard navigation within menus (Tab/Shift+Tab).
class NextMenuFocusIntent extends Intent {
  /// Whether to move focus forward (true) or backward (false).
  final bool forward;
  /// Creates a next menu focus intent.
  ///
  /// Parameters:
  /// - [forward] (bool, required): Direction of focus movement
  const NextMenuFocusIntent(this.forward);
}
```
