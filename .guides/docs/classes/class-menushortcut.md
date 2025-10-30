---
title: "Class: MenuShortcut"
description: "Displays a keyboard shortcut in a menu."
---

```dart
/// Displays a keyboard shortcut in a menu.
///
/// Renders the visual representation of a keyboard shortcut, typically
/// displayed on the right side of menu items.
///
/// Example:
/// ```dart
/// MenuShortcut(
///   activator: SingleActivator(LogicalKeyboardKey.keyS, control: true),
/// )
/// ```
class MenuShortcut extends StatelessWidget {
  /// The keyboard shortcut to display.
  final ShortcutActivator activator;
  /// Widget to display between multiple keys.
  final Widget? combiner;
  /// Creates a [MenuShortcut].
  ///
  /// Parameters:
  /// - [activator] (`ShortcutActivator`, required): The shortcut to display.
  /// - [combiner] (`Widget?`, optional): Separator between keys (default: " + ").
  const MenuShortcut({super.key, required this.activator, this.combiner});
  Widget build(BuildContext context);
}
```
