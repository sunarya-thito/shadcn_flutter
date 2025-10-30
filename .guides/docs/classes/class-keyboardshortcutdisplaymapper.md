---
title: "Class: KeyboardShortcutDisplayMapper"
description: "Widget that provides keyboard shortcut display customization."
---

```dart
/// Widget that provides keyboard shortcut display customization.
///
/// Allows customization of how keyboard shortcuts are displayed
/// throughout the widget tree using a builder function.
class KeyboardShortcutDisplayMapper extends StatefulWidget {
  /// The builder function for creating key displays.
  final KeyboardShortcutDisplayBuilder builder;
  /// The child widget that will have access to this mapper.
  final Widget child;
  /// Creates a keyboard shortcut display mapper.
  const KeyboardShortcutDisplayMapper({super.key, this.builder = _defaultBuilder, required this.child});
  State<KeyboardShortcutDisplayMapper> createState();
}
```
