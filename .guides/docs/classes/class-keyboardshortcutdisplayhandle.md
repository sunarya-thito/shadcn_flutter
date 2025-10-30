---
title: "Class: KeyboardShortcutDisplayHandle"
description: "Handle for accessing keyboard shortcut display builders."
---

```dart
/// Handle for accessing keyboard shortcut display builders.
///
/// Wraps a keyboard shortcut display builder function to provide
/// a consistent API for building key displays.
class KeyboardShortcutDisplayHandle {
  /// Creates a handle with the specified builder.
  const KeyboardShortcutDisplayHandle(this._builder);
  /// Builds a display widget for the specified keyboard key.
  Widget buildKeyboardDisplay(BuildContext context, LogicalKeyboardKey key);
}
```
